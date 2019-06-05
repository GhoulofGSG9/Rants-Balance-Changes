if not Server then return end

function PulseGrenade:OnUpdate(deltaTime)

    PredictedProjectile.OnUpdate(self, deltaTime)

    for _, enemy in ipairs( GetEntitiesForTeamWithinRange("Alien", GetEnemyTeamNumber(self:GetTeamNumber()), self:GetOrigin(), 1) ) do

        if enemy:GetIsAlive() then
            self:Detonate()
            break
        end

    end

end