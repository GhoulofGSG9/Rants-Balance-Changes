-- We cannot use simple network messages to propagate global changes due to the fact that the
-- Predict world cannot receive network messages... So we create a short-lived entity that will
-- set these values in its Initialize method, then shortly after destroy itself.

class "GlobalChangePropagator" (Entity)

GlobalChangePropagator.kMapName = "globalchangepropagator"

local netVars =
{
    globalPath = "string (256)",
    value = "float",
    requestingClientIndex = "entityid",
}

function GlobalChangePropagator:OnCreate()

    Entity.OnCreate(self)

    self.globalPath = ""
    self.value = 0
    self.requestingClientIndex = -1

    self:SetUpdates(false)
    self:SetPropagate(Entity.Propagate_Always)

end

-- Attempts to follow the given path to find a particular field.
-- Eg. Onos.kChargeFriction --> _G["Onos"]["kChargeFriction"]
-- Returns 3 values:
--      errorMessage (nil if successful)
--      parent (table/object that contains the field requested) (nil if failed)
--      key (string name of field) (nil if failed)
local function TraversePath(path)

    local pathTbl = string.Explode(path, "%.")
    if #pathTbl == 0 then
        return "Invalid path provided! (path cannot be empty)"
    end

    local parent = _G -- start in global scope.
    local pathSoFar = "" -- for error message printing.
    for i=1, #pathTbl - 1 do

        local key = pathTbl[i]
        if key == "" then
            return "Invalid path provided! (cannot have blank keys)"
        end

        -- Check if the path is valid up to this point.
        local newParent = parent[key]
        if newParent == nil then
            if pathSoFar == "" then
                return string.format("Unable to find global value named '%s'", key)
            else
                return string.format("Unable to find value named '%s' at '%s'", key, pathSoFar)
            end
        end

        -- Append the key to the path so far.
        parent = newParent
        if pathSoFar == "" then
            pathSoFar = key
        else
            pathSoFar = pathSoFar .. "." .. key
        end

    end

    -- Ensure last value exists.
    local lastKey = pathTbl[#pathTbl]
    if parent[lastKey] == nil then
        if pathSoFar == "" then
            return string.format("Unable to find global value named '%s'", lastKey)
        else
            return string.format("Unable to find value named '%s' at '%s'", lastKey, pathSoFar)
        end
    end

    -- Ensure value is numeric (this only works for number values currently).
    if type(parent[lastKey]) ~= "number" then
        return string.format("Found non-numeric value at '%s.%s'.  This only works for numeric values.", pathSoFar, lastKey)
    end

    -- Success!
    return nil, parent, lastKey

end

local function DestroySelf(self)

    DestroyEntity(self)

    return false -- don't repeat

end

function GlobalChangePropagator:OnInitialized()

    Entity.OnInitialized(self)

    assert(type(self.globalPath) == "string")
    assert(self.globalPath ~= "")

    assert(type(self.value) == "number")

    if Server then

        -- The value must exist on the server for it to be successful.
        local errorMsg, parent, lastKey = TraversePath(self.globalPath)
        if errorMsg then

            local client = Server.GetClientById(self.requestingClientIndex)
            if not client then
                return
            end

            Server.SendNetworkMessage(client, "SetGlobalResponse", {msg = errorMsg}, true)
            return

        end

        -- Set the value.
        local oldValue = parent[lastKey]
        parent[lastKey] = self.value

        Log("(Server) %s changed from %s to %s", self.globalPath, oldValue, self.value)

        -- Destroy this entity after a short time.  Don't immediately destroy the entity, as we
        -- want to make sure it lives long enough to be propagated to all clients, even those with
        -- lossy connections.
        self:AddTimedCallback(DestroySelf, 1)



    else -- Client or Predict

        -- Some globals are server-only.  Try to set it on the client/predict, and if it fails,
        -- just move on.
        local errorMsg, parent, lastKey = TraversePath(self.globalPath)
        if errorMsg then
            return
        end

        local oldValue = parent[lastKey]
        parent[lastKey] = self.value

        if Client then
            Log("(Client) %s changed from %s to %s", self.globalPath, oldValue, self.value)
        else
            Log("(Predict) %s changed from %s to %s", self.globalPath, oldValue, self.value)
        end

    end

end

Shared.LinkClassToMap("GlobalChangePropagator", GlobalChangePropagator.kMapName, netVars)