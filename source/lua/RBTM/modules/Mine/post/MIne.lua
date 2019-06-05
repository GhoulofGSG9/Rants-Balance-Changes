-- The amount of time until the mine is detonated once armed.
local kTimeArmed = 0.1

-- The amount of time it takes other mines to trigger their detonate sequence when nearby mines explode.
local kTimedDestruction = 0.5

-- range in which other mines are trigger when detonating
local kMineChainDetonateRange = 3

local kMineCameraShakeDistance = 15
local kMineMinShakeIntensity = 0.01
local kMineMaxShakeIntensity = 0.13

function Mine:Detonate()
    if not self.active then return end


    local hitEntities = GetEntitiesWithMixinWithinRange("Live", self:GetOrigin(), kMineDetonateRange)
    RadiusDamage(hitEntities, self:GetOrigin(), kMineDetonateRange, kMineDamage, self, false, SineFalloff)

    -- Start the timed destruction sequence for any mine within range of this exploded mine.
    local nearbyMines = GetEntitiesWithinRange("Mine", self:GetOrigin(), kMineChainDetonateRange)
    for _, mine in ipairs(nearbyMines) do

        if mine ~= self and not mine.armed then
            mine:AddTimedCallback(mine.Arm, (math.random() + math.random()) * kTimedDestruction)
        end

    end

    local params = {}
    params[kEffectHostCoords] = Coords.GetLookIn( self:GetOrigin(), self:GetCoords().zAxis )

    params[kEffectSurface] = "metal"

    self:TriggerEffects("mine_explode", params)

    DestroyEntity(self)

    CreateExplosionDecals(self)
    TriggerCameraShake(self, kMineMinShakeIntensity, kMineMaxShakeIntensity, kMineCameraShakeDistance)

end

function Mine:Arm()
    if not self.active then return end

    if not self.armed then

        self:AddTimedCallback(self.Detonate, kTimeArmed)

        self:TriggerEffects("mine_arm")

        self.armed = true

    end

end

function Mine:CheckEntityExplodesMine(entity)

    if not self.active then
        return false
    end

    if entity:isa("Hallucination") or entity.isHallucination then
        return false
    end

    if not HasMixin(entity, "Team") or GetEnemyTeamNumber(self:GetTeamNumber()) ~= entity:GetTeamNumber() then
        return false
    end

    if not HasMixin(entity, "Live") or not entity:GetIsAlive() or not entity:GetCanTakeDamage() then
        return false
    end

    if not (entity:isa("Player") or entity:isa("Whip") or entity:isa("Babbler")) then
        return false
    end

    if entity:isa("Commander") then
        return false
    end

    if entity:isa("Fade") and entity:GetIsBlinking() then

        return false

    end

    local minePos = self:GetEngagementPoint()
    local targetPos = entity:GetEngagementPoint()
    -- Do not trigger through walls. But do trigger through other entities.
    if not GetWallBetween(minePos, targetPos, entity) then

        -- If this fails, targets can sit in trigger, no "polling" update performed.
        self:Arm()
        return true

    end

    return false

end

function Mine:CheckAllEntsInTriggerExplodeMine(self)

    local ents = self:GetEntitiesInTrigger()
    for e = 1, #ents do
        self:CheckEntityExplodesMine(ents[e])
    end

end

function Mine:OnInitialized()

    ScriptActor.OnInitialized(self)

    if Server then

        InitMixin(self, InfestationTrackerMixin)

        self.active = false
        self:AddTimedCallback(self.Activate, kMineActiveTime)

        self.armed = false
        self:SetHealth(self:GetMaxHealth())
        self:SetArmor(self:GetMaxArmor())
        self:TriggerEffects("mine_spawn")

        InitMixin(self, TriggerMixin)
        self:SetSphere(kMineTriggerRange)

    end

    self:SetModel(Mine.kModelName)

end

if Server then
    function Mine:Activate()
        self.active = true
        self:CheckAllEntsInTriggerExplodeMine()
    end

    function Mine:OnTouchInfestation()
        self:Arm()
    end

    function Mine:OnStun()
        self:Arm()
    end

    function Mine:OnKill(attacker, doer, point, direction)

        self:Arm()

        ScriptActor.OnKill(self, attacker, doer, point, direction)

    end

    function Mine:OnTriggerEntered(entity)
        self:CheckEntityExplodesMine(entity)
    end

    --
    -- We need to check when there are entities within the trigger area often.
    --
    function Mine:OnUpdate()

        local now = Shared.GetTime()
        self.lastMineUpdateTime = self.lastMineUpdateTime or now
        if now - self.lastMineUpdateTime >= 0.5 then

            self:CheckAllEntsInTriggerExplodeMine()
            self.lastMineUpdateTime = now

        end

    end

end

