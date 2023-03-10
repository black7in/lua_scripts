--[[
    [LUA] TNT RUN EVENT Azerothcore/Trinitycore 3.3.5a
]]
local gob = 100000
local npc = 100000
local status = false


local function GenerarPlataformas( object )
    local position_x = -1680.0
    local position_y = 572.5
    local postion_z = 27.0
    local orientation = 3.20

    local platformWidth = 1
    local numCols = 40
    local numRows = 40

    local nivel = 3

    for i = 1, nivel, 1 do
        for i = 1, numRows, 1 do
            for i = 1, numCols, 1 do
                object:SummonGameObject( gob, position_x, position_y, postion_z, orientation, 1800)
                position_y = position_y + platformWidth
            end
            position_y = 572.5
            position_x = position_x + platformWidth
        end
        position_x = -1680.0
        postion_z = postion_z - 10.0
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