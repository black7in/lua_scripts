local fallEvent = {}

fallEvent.npc = 196 -- npc entry
fallEvent.gob = 990000
fallEvent.listPlayers = {}
fallEvent.nPlayers = 0
fallEvent.startTime = 0

local time = 10 -- 10 sec to drop a platform
local statusEvent = false
local count = 25 -- n plataform

local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3
local FALL_EVENT_PLAYER_REMAINING = 6000
local FALL_EVENT_PLATAFORM_REDUCTION = 6001
local FALL_EVENT = 6002


function fallEvent.OnGossipHello(event, player, object)
    if not statusEvent and not fallEvent.CheckPlayer(player) then
        player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tEntrar al evento.", 0, 1 )
    end
    player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tParticipantes: " .."|CFFFF0000"..fallEvent.nPlayers.."|r", 0, 2 )
    if player:IsGM() and not statusEvent then
        player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tIniciar Evento", 0, 3 )
    end
    if player:IsGM() and statusEvent then
        player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tReiniciar Evento", 0, 4 )
    end
    player:GossipMenuAddItem( 5, "|TINTERFACE/ICONS/Achievement_Reputation_06:28:28:-15:0|tAdios!.", 0, 5 )
    player:GossipSendMenu( 1, object )
end RegisterCreatureGossipEvent( fallEvent.npc, 1, fallEvent.OnGossipHello )

function fallEvent.OnGossipSelect(event, player, object, sender, intid, code, menu_id)
    if intid == 1 then
        fallEvent.listPlayers[fallEvent.nPlayers + 1] = player:GetGUIDLow()
        fallEvent.nPlayers = fallEvent.nPlayers + 1
        fallEvent.OnGossipHello(event, player, object)
    elseif intid == 2 then
        fallEvent.OnGossipHello(event, player, object)
    elseif intid == 3 then
        local players = object:GetPlayersInRange( 100 )
        for i = 1, #fallEvent.listPlayers, 1 do
            local pl = GetPlayerByGUID (fallEvent.listPlayers[i])
            pl:Teleport( 1, -8571.91, 1995.77, 110.47, 0.38 )
        end
        for i = 1, #players, 1 do
            players[i]:InitializeWorldState(1, 0, FALL_EVENT, 10)
            players[i]:UpdateWorldState(FALL_EVENT_PLAYER_REMAINING, fallEvent.nPlayers)
            players[i]:UpdateWorldState(FALL_EVENT_PLATAFORM_REDUCTION, time)
        end
        statusEvent = true
        fallEvent.startTime = fallEvent.GetTime()
        player:GossipComplete()
    elseif intid == 4 then
        object:SetPhaseMask(2)
        local gameObjectsInRange = object:GetGameObjectsInRange( 100, fallEvent.gob )
        for i = 1, #gameObjectsInRange, 1 do
            gameObjectsInRange[i]:SetPhaseMask( 1 )
        end
        object:SetPhaseMask(1)
        count = 25
        statusEvent = false
        local players = object:GetPlayersInRange( 100 )
        for i = 1, #players, 1 do
            players[i]:InitializeWorldState(0, 0, 0, 0)
            players[i]:UpdateWorldState(0, 0)
        end
        fallEvent.listPlayers = {}
        fallEvent.nPlayers = 0
        fallEvent.startTime = 0
        fallEvent.OnGossipHello(event, player, object)
    elseif intid == 5 then
        player:GossipComplete()
    end
end RegisterCreatureGossipEvent( fallEvent.npc, 2, fallEvent.OnGossipSelect )

function fallEvent.UpdateAI(event, creature, diff)
    if statusEvent == false then
        return
    end
    for i = 1, #fallEvent.listPlayers, 1 do
        if fallEvent.listPlayers[i] ~= nil then
            local pl = GetPlayerByGUID (fallEvent.listPlayers[i])
            if pl:ToPlayer() then
                local z = pl:GetZ()
                if z < 104 then
                    fallEvent.nPlayers = fallEvent.nPlayers - 1
                    creature:SendUnitYell( "El jugador: "..pl:GetName().." cayó y está fuera del evento!", 0 )
                    fallEvent.listPlayers[i] = nil
                    local players = creature:GetPlayersInRange( 100 )
                    for i = 1, #players, 1 do
                        players[i]:UpdateWorldState(FALL_EVENT_PLAYER_REMAINING, fallEvent.nPlayers)
                    end
                end

            end
        end
    end
    if fallEvent.nPlayers <= 1 then
        return
    end
    if count <= 1 then
        return
    end
    if fallEvent.GetTime() - fallEvent.startTime == 1 then
        fallEvent.startTime = fallEvent.startTime + 1
        local players = creature:GetPlayersInRange( 100 )
        if time > 0 then
            time = time - 1
            for i = 1, #players, 1 do
                players[i]:UpdateWorldState(FALL_EVENT_PLATAFORM_REDUCTION, time)
            end
            if time == 0 then
                count = count - 1
                local gameObjectsInRange = creature:GetGameObjectsInRange( 100, fallEvent.gob )
                for i = 1, #gameObjectsInRange, 1 do
                    local c = math.random(1, #gameObjectsInRange)
                    if gameObjectsInRange[c]:GetPhaseMask() == 1 then
                        for i = 1, #players, 1 do
                            gameObjectsInRange[c]:PlayDirectSound( 1400, players[i] )
                        end
                        gameObjectsInRange[c]:SetPhaseMask( 2 )
                        break
                    end
                end
            end
            
        else
            time = 10
            for i = 1, #players, 1 do
                players[i]:UpdateWorldState(FALL_EVENT_PLATAFORM_REDUCTION, time)
            end
        end
    end

end RegisterCreatureEvent( fallEvent.npc, 7, fallEvent.UpdateAI )

function fallEvent.CheckPlayer(player)
    for i = 1, fallEvent.nPlayers, 1 do
        if player:GetGUIDLow() == fallEvent.listPlayers[i] then
            return true
        end
    end 
    return false
end
function Player:InitializeWorldState(Map, Zone, StateID, Value)
    local data = CreatePacket(SMSG_INIT_WORLD_STATES, 18);
    data:WriteULong(Map);
    data:WriteULong(Zone);
    data:WriteULong(0);
    data:WriteUShort(1);
    data:WriteULong(StateID);
    data:WriteULong(Value);
    self:SendPacket(data)
end
function Player:UpdateWorldState(StateID, Value)
    local data = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8);
    data:WriteULong(StateID);
    data:WriteULong(Value);
    self:SendPacket(data)
end
function fallEvent.GetTime()
    local actual = os.time()
    return actual
end