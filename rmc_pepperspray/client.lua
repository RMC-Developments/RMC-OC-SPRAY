local QBCore = exports['qb-core']:GetCoreObject()

-- Configuration
local PEPPER_SPRAY_WEAPON = "weapon_pepperspray"
local SPRAY_RANGE = 5.0
local SPRAY_COOLDOWN = 5000 -- 2 seconds
local lastSprayTime = 0

-- Function to find the closest player
function GetClosestPlayer()
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = nil
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(playerCoords - targetCoords)

            if closestDistance == -1 or distance < closestDistance then
                closestDistance = distance
                closestPlayer = playerId
            end
        end
    end

    return closestPlayer, closestDistance
end

-- Function to spray the pepper spray
function SprayPepperSpray()
    local playerPed = PlayerPedId()
    local weapon = GetSelectedPedWeapon(playerPed)
    local currentTime = GetGameTimer()

    -- Ensure player is holding the correct weapon and cooldown has passed
    if weapon ~= GetHashKey(PEPPER_SPRAY_WEAPON) or (currentTime - lastSprayTime) < SPRAY_COOLDOWN then return end

    lastSprayTime = currentTime
    
    -- Get the correct muzzle bone index (Gun Barrel)
    local muzzleBoneIndex = GetPedBoneIndex(playerPed, 6286)
    local muzzleOffset = vector3(0.0, 0.0, 0.0)
    local muzzleRotation = vector3(0.0, 90.0, 0.0)

    -- Notify all players to display the spray effect
    TriggerServerEvent("qb-pepperspray:syncSpray", GetPlayerServerId(PlayerId()), muzzleOffset, muzzleRotation, muzzleBoneIndex)

    -- Apply effects to the nearest player if they are close enough
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer and closestDistance < SPRAY_RANGE then
        TriggerServerEvent("qb-pepperspray:use", GetPlayerServerId(closestPlayer))
    end
end

-- Detect when player presses Left Click while aiming
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsPlayerFreeAiming(PlayerId()) and IsControlJustPressed(0, 24) then -- Left Click
            SprayPepperSpray()
        end
    end
end)

-- Event to play spray effect for all players
RegisterNetEvent("qb-pepperspray:playSprayEffect", function(playerId, muzzleOffset, muzzleRotation, muzzleBoneIndex)
    local playerPed = GetPlayerPed(GetPlayerFromServerId(playerId))
    if DoesEntityExist(playerPed) then
        RequestNamedPtfxAsset("core")
        while not HasNamedPtfxAssetLoaded("core") do
            Citizen.Wait(10)
        end
        UseParticleFxAssetNextCall("core")

        StartParticleFxLoopedOnEntityBone(
            "ent_sht_steam", 
            playerPed,
            muzzleOffset.x, muzzleOffset.y, muzzleOffset.z,
            muzzleRotation.x, muzzleRotation.y, muzzleRotation.z,
            muzzleBoneIndex,
            1.0, false, false, false
        )
    end
end)

-- Apply the actual pepper spray effects to the target player
RegisterNetEvent("qb-pepperspray:applyEffects", function()
    local playerPed = PlayerPedId()
    TriggerScreenblurFadeIn(1)
    RequestAnimSet("move_m@drunk@verydrunk")
    while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(10)
    end
    SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", 1.0)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_COUGHING", 0, true)
    Citizen.Wait(5000)
    ResetPedMovementClipset(playerPed, 0)
    ClearPedTasksImmediately(playerPed)
    TriggerScreenblurFadeOut(1)
end)
