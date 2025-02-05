local QBCore = exports['qb-core']:GetCoreObject()

local ItemTable = {
    "water_bottle",
    "lockpick",
    "advancedlockpick",
    "goldchain",
    "trojan_usb",
    "crack_baggy",
    "cokebaggy",
    "pistol_ammo",
    "thermite",
    "nitrous",
    "walkstick",
    "gatecrack",
    "screwdriverset",
    "xtcbaggy",
    "smg_ammo",
    "shotgun_ammo",
    "tosti",
    "markedbills",
    "handcuffs",
    "joint",
    "oxy",
    "weed_zero-haze",
    "iphone",
}

function NearTaxi(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.NPCLocations.DeliverLocations) do
        local dist = #(coords - vector3(v.x,v.y,v.z))
        if dist < 20 then
            return true
        end
    end
end

RegisterNetEvent('qb-taxi:server:NpcPay', function(Payment)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "taxi" then
        if NearTaxi(src) then
            local randomAmount = math.random(1, 5)
            local r1, r2 = math.random(1, 5), math.random(1, 5)
            if randomAmount == r1 or randomAmount == r2 then Payment = Payment + math.random(10, 20) end
            Player.Functions.AddMoney('cash', Payment)
            local chance = math.random(1, 100)
            if chance < 26 then
                local randItem = ItemTable[math.random(1, #ItemTable)]
                Player.Functions.AddItem(randItem, 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], "add")
            end
        else
            DropPlayer(src, 'Attempting To Exploit')
        end
    else
        DropPlayer(src, 'Attempting To Exploit')
    end
end)
