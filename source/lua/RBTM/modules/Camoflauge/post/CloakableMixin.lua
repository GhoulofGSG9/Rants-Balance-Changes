local kPlayerMaxCloak = 0.88
local function UpdateDesiredCloakFraction(self, deltaTime)

    if Server then

        self.cloakingDesired = false

        -- Animate towards uncloaked if triggered
        if Shared.GetTime() > self.timeUncloaked and (not HasMixin(self, "Detectable") or not self:GetIsDetected()) and ( not GetConcedeSequenceActive() ) then

            -- Uncloaking takes precedence over cloaking
            if Shared.GetTime() < self.timeCloaked then
                self.cloakingDesired = true
                self.cloakRate = 3
            elseif self.GetIsCamouflaged and self:GetIsCamouflaged() then

                self.cloakingDesired = true

                if self:isa("Player") then
                    self.cloakRate = self:GetVeilLevel()
                elseif self:isa("Babbler") then
                    local babblerParent = self:GetParent()
                    if babblerParent and HasMixin(babblerParent, "Cloakable") then
                        self.cloakRate = babblerParent.cloakRate
                    end
                else
                    self.cloakRate = 3
                end

            end

        end

    end

    local newDesiredCloakFraction = self.cloakingDesired and 1 or 0

    -- Update cloaked fraction according to our speed and max speed
    if self.GetSpeedScalar then
        -- TODO: Fix that GetSpeedScalar returns incorrect values for aliens with celerity
        local speedScalar = math.min(self:GetSpeedScalar(), 1)
        newDesiredCloakFraction = newDesiredCloakFraction - speedScalar
        self.speedScalar = speedScalar * 3
    end

    if newDesiredCloakFraction ~= nil then
        self.desiredCloakFraction = Clamp(newDesiredCloakFraction, 0, (self:isa("Player") or self:isa("Drifter") or self:isa("Babbler")) and kPlayerMaxCloak or 1)
    end

end

debug.setupvaluex(CloakableMixin.OnUpdate, "UpdateDesiredCloakFraction", UpdateDesiredCloakFraction)