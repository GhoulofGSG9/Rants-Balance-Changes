debug.appendtoenum(kDamageType, 'ClusterFlame')
debug.appendtoenum(kDamageTypeDesc, "ClusterFlame: Deals 5x damage vs. flammable structures and 2.5x vs. all other structures, 50% reduction in player damage")

local kClusterStructuralDamageScalar = 2.5
local kClusterPlayerDamageScalar = 0.5
local function ClusterFlameModifier(target, _, _, damage, armorFractionUsed, healthPerArmor, damageType)
    if target:isa("Player") then
        damage = damage * kClusterPlayerDamageScalar
    else
        if target.GetReceivesStructuralDamage and target:GetReceivesStructuralDamage(damageType) then
            damage = damage * kClusterStructuralDamageScalar
        end

        if target.GetIsFlameAble and target:GetIsFlameAble(damageType) then
            damage = damage * 2
        end
    end

    return damage, armorFractionUsed, healthPerArmor
end

-- Prepare for hacky code in 3 .. 2 .. 1
local old = debug.getupvaluex(GetDamageByType, "BuildDamageTypeRules")
local function BuildDamageTypeRules()
    old()

    kDamageTypeRules[kDamageType.ClusterFlame] = {
        ClusterFlameModifier
    }
end
debug.setupvaluex(GetDamageByType, "BuildDamageTypeRules", BuildDamageTypeRules)