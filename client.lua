
local LoadModels = function(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end
local ObjectSpawner = function(hash, x, y ,z, heading)
    LoadModels(hash)
    local obj = CreateObject(hash, x, y, z- 1, true, false)
    FreezeEntityPosition(obj, true)
    SetEntityHeading(obj, heading)
end
local PedSpawner = function(hash, coord, heading, scenario)
    LoadModels(hash)
    local ped = CreatePed(2, hash, coord.x, coord.y, coord.z - 1, heading, true, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    TaskSetBlockingOfNonTemporaryEvents(ped , true)
    SetEntityHeading(ped, heading)
    TaskStartScenarioInPlace(ped, scenario, -1, 1)
end


CreateThread(function()
    for k, v in pairs(Config.Object) do
        ObjectSpawner(v.object, v.coord.x, v.coord.y, v.coord.z, v.heading)
    end
end)
CreateThread(function()
    for k, v in pairs(Config.Peds) do
        PedSpawner(v.hash, v.coord, v.heading, v.animition)
    end
end)