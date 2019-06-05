if not Server then return end -- Server only

local kLifeTime = 7.5
debug.setupvaluex(GasGrenade.OnCreate, "kLifeTime", kLifeTime)

local kNerveGasCloudLifetime = 4.5
debug.setupvaluex(NerveGasCloud.OnCreate, "kNerveGasCloudLifetime", kNerveGasCloudLifetime)