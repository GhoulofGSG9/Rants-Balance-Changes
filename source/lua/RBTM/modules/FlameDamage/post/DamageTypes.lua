local function MultiplyFlameAble(target, attacker, doer, damage, armorFractionUsed, healthPerArmor, damageType)
    if target.GetIsFlameAble and target:GetIsFlameAble(damageType) then
        local multi = kFlameableMultiplier
        if target.GetIsFlameableMultiplier then
            multi = target:GetIsFlameableMultiplier()
        end

        damage = damage * multi
    end

    return damage, armorFractionUsed, healthPerArmor
end
debug.setupvaluex(GetDamageByType, "MultiplyFlameAble", MultiplyFlameAble)