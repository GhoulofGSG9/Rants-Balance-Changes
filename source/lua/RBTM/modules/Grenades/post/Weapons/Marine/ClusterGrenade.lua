if not Server then return end -- Server only

local kGrenadeCameraShakeDistance = 15
local kGrenadeMinShakeIntensity = 0.01
local kGrenadeMaxShakeIntensity = 0.12

function ClusterGrenade:BurnNearbyAbilities()
    local origin = self:GetOrigin()
    local range = kClusterGrenadeDamageRadius

    -- lerk spores
    local spores = GetEntitiesWithinRange("SporeCloud", origin, range)

    -- lerk umbra
    local umbras = GetEntitiesWithinRange("CragUmbra", origin, range)

    -- bilebomb (gorge and contamination), whip bomb
    local bombs = GetEntitiesWithinRange("Bomb", origin, range)
    local whipBombs = GetEntitiesWithinRange("WhipBomb", origin, range)

    for _, spore in ipairs(spores) do
        self:TriggerEffects("burn_spore", {effecthostcoords = Coords.GetTranslation(spore:GetOrigin())})
        DestroyEntity(spore)
    end

    for _, umbra in ipairs(umbras) do
        self:TriggerEffects("burn_umbra", {effecthostcoords = Coords.GetTranslation(umbra:GetOrigin())})
        DestroyEntity(umbra)
    end

    for _, bomb in ipairs(bombs) do
        self:TriggerEffects("burn_bomb", {effecthostcoords = Coords.GetTranslation(bomb:GetOrigin())})
        DestroyEntity(bomb)
    end

    for _, bomb in ipairs(whipBombs) do
        self:TriggerEffects("burn_bomb", {effecthostcoords = Coords.GetTranslation(bomb:GetOrigin())})
        DestroyEntity(bomb)
    end
end

function ClusterGrenade:BurnEntities(ents)
    local owner = self:GetOwner()
    for i = 1, #ents do
        local ent = ents[i]
        if HasMixin(ent, "Fire") and GetAreEnemies(self, ent) then
            ent:SetOnFire(ent, owner)
        end
    end
end

local kClusterGrenadeFragmentPoints =
{
    Vector(0.1, 0.12, 0.1),
    Vector(-0.1, 0.12, -0.1),
    Vector(0.1, 0.12, -0.1),
    Vector(-0.1, 0.12, 0.1),

    Vector(-0.0, 0.12, 0.1),
    Vector(-0.1, 0.12, 0.0),
    Vector(0.1, 0.12, 0.0),
    Vector(0.0, 0.12, -0.1),
}

function ClusterGrenade:CreateFragments()

    local origin = self:GetOrigin()
    local player = self:GetOwner()

    for i = 1, #kClusterGrenadeFragmentPoints do

        local creationPoint = origin + kClusterGrenadeFragmentPoints[i]
        local fragment = CreateEntity(ClusterFragment.kMapName, creationPoint, self:GetTeamNumber())

        local startVelocity = GetNormalizedVector(creationPoint - origin) * (3 + math.random() * 6) + Vector(0, 4 * math.random(), 0)
        fragment:Setup(player, startVelocity, true, nil, self)

    end

end

function ClusterGrenade:Detonate(targetHit)

    self:CreateFragments()

    local hitEntities = GetEntitiesWithMixinWithinRange("Live", self:GetOrigin(), kClusterGrenadeDamageRadius)
    table.removevalue(hitEntities, self)

    self:BurnEntities(hitEntities)
    self:BurnNearbyAbilities()

    if targetHit then
        table.removevalue(hitEntities, targetHit)
        self:DoDamage(kClusterGrenadeDamage, targetHit, targetHit:GetOrigin(), GetNormalizedVector(targetHit:GetOrigin() - self:GetOrigin()), "none")
    end

    RadiusDamage(hitEntities, self:GetOrigin(), kClusterGrenadeDamageRadius, kClusterGrenadeDamage, self)

    local surface = GetSurfaceFromEntity(targetHit)

    local params = { surface = surface }
    if not targetHit then
        params[kEffectHostCoords] = Coords.GetLookIn( self:GetOrigin(), self:GetCoords().zAxis)
    end

    self:TriggerEffects("cluster_grenade_explode", params)
    CreateExplosionDecals(self)
    TriggerCameraShake(self, kGrenadeMinShakeIntensity, kGrenadeMaxShakeIntensity, kGrenadeCameraShakeDistance)

    DestroyEntity(self)

end

