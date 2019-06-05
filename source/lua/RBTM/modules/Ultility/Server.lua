Server.HookNetworkMessage("SetGlobalRequest", function(client, message)

    Server.CreateEntity(GlobalChangePropagator.kMapName, {globalPath = message.globalPath, value = message.value, requestingClientIndex = client:GetId()})

end)