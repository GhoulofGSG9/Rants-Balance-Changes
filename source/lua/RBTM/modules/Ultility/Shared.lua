Script.Load("lua/RBTM/modules/Ultility/new/GlobalChangePropagator.lua")

Shared.RegisterNetworkMessage("SetGlobalRequest", { globalPath = "string (256)", value = "float" })