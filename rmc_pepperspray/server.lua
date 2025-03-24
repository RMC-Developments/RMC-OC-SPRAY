local QBCore = exports['qb-core']:GetCoreObject()

-- Configuration
local COOLDOWN_TIME = 5 -- Cooldown between sprays (seconds)
local ALLOWED_JOBS = {"police"} -- Jobs allowed to use the pepper spray

local lastSprayTime = {}

-- Function to check if a value exists in a table
local function hasValue(tab, val)
    for _, v in ipairs(tab) do
        if v == val then return true end
    end
    return false
end

-- Event to apply the pepper spray effects on a target player
RegisterNetEvent("qb-pepperspray:use", function(targetId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(targetId)

    if not Player or not Target then return end

    local job = Player.PlayerData.job.name
    if not hasValue(ALLOWED_JOBS, job) then
        TriggerClientEvent("QBCore:Notify", src, "You are not authorized to use this!", "error")
        return
    end

    if lastSprayTime[src] and (os.time() - lastSprayTime[src]) < COOLDOWN_TIME then
        TriggerClientEvent("QBCore:Notify", src, "Cooldown active!", "error")
        return
    end

    lastSprayTime[src] = os.time()

    -- Apply effects to the target
    TriggerClientEvent("qb-pepperspray:applyEffects", targetId)

    -- Notify attacker
    TriggerClientEvent("QBCore:Notify", src, "You sprayed " .. Target.PlayerData.charinfo.firstname .. "!", "success")
end)

-- Event to sync spray particles for all players
RegisterNetEvent("qb-pepperspray:syncSpray", function(playerId, muzzleOffset, muzzleRotation, muzzleBoneIndex)
    local src = source
    TriggerClientEvent("qb-pepperspray:playSprayEffect", -1, playerId, muzzleOffset, muzzleRotation, muzzleBoneIndex)
end)
