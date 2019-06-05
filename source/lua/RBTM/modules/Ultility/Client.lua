Event.Hook("Console_set_global", function(globalPath, value)

    if not Shared.GetCheatsEnabled() and not Shared.GetDevMode() then
        Log("set_global only works with dev mode enabled")
        return
    end

    -- Validate inputs
    local valueAsNum = tonumber(value)
    if globalPath == nil or type(valueAsNum) ~= "number" then
        Log("Usage: set_global globalPath number")
        return
    end

    Client.SendNetworkMessage("SetGlobalRequest", { globalPath = globalPath, value = valueAsNum }, true)

end)
