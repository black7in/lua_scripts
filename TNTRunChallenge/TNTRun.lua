--[[
    [LUA] TNT RUN EVENT World of Warcraft 3.3.5a
]]
local gob = 100000
local npc = 196
local status = false

local function GenerarPlataformas(object)
    local x = -1652.1350
    local y = 568.9259
    local z = 27.2826
    local filas = 51
    local columnas = 5
    local pisos = 3
    for j = 1, pisos, 1 do
        for i = 1, filas, 1 do
            for k = 1, columnas, 1 do
                object:SummonGameObject( gob, x, y, z, 4.7022, 1800)
                x = x + 1
            end
            if i <= (filas / 2) - 0.5 - 1 then
                x = -1652.1350 - i
                y = 568.9259 + i
                columnas = columnas + 2
            elseif i == (filas / 2) - 0.5 then
                x = -1652.1350 - (i - 1)
                y = 568.9259 + i
            elseif i == (filas / 2) - 0.5 + 1 then
                x = -1652.1350 - (i - 2)
                y = 568.9259 + i
            else
                x = -1652.1350 - filas + i + 1
                y = 568.9259 + i
                columnas = columnas - 2
            end
        end
        z = z - 10
    end
end

local function EliminarPlataformas(object)
    local gameObjectsInRange = object:GetGameObjectsInRange( 100, gob )
    for i = 1, #gameObjectsInRange, 1 do
        gameObjectsInRange[i]:Despawn()
    end
end

local function OnAIUpdate(event, go, diff)
    local playersInRange = go:GetPlayersInRange( -1.3 )
    if playersInRange[1] then
        go:Despawn()
    end
end RegisterGameObjectEvent( gob, 1, OnAIUpdate )

local function OnGossipHello(event, player, object)
    if player:IsGM() and not status then
        player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tGenerar plataformas.", 0, 1 )
    end
    if player:IsGM() then
        player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tRestaurar plataformas", 0, 2 )
        player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tEliminar plataformas", 0, 3 )
    end
    if status then
        player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tSubir a la plataforma", 0, 4 )
    end
    player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/Achievement_Reputation_06:28:28:-15:0|tNo quiero nada.", 0, 5 )
    player:GossipSendMenu( 1, object )
end RegisterCreatureGossipEvent( npc, 1, OnGossipHello )

local function OnGossipSelect(event, player, object, sender, intid, code, menu_id)
    if intid == 1 then
        GenerarPlataformas(object)
        object:SummonGameObject( 186300, -1686.3374, 594.9182, 29.5670, 6.24, 1800)
        status = true
    elseif intid == 2 then
        EliminarPlataformas(object)
        GenerarPlataformas(object)
    elseif intid == 3 then
        EliminarPlataformas(object)
        local gameObjectsInRange = object:GetGameObjectsInRange( 100, 186300 )
        for i = 1, #gameObjectsInRange, 1 do
            gameObjectsInRange[i]:Despawn()
        end
        status = false
    elseif intid == 4 then
        player:Teleport( 36, -1688.544, 595.223, 36.93, 6.10 )
        player:CastSpell(player, 64446)
    elseif intid == 5 then
        player:GossipComplete()
    end
    player:GossipComplete()
end RegisterCreatureGossipEvent( npc, 2, OnGossipSelect )