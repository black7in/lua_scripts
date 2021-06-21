--[[
    KillStreak for BG with custom Dota2 sound TrinityCore/AzerothCore 3.3.5a
    elperroblack#6996
]]
local BG = {}
local sounds = {
    firstblood = 20000, -- First Blood
    multiKill = {20001, -- Killing 2 in quick succession ( + 10s) - Double kill
    20002, -- Killing 3 in quick succession ( + 10s) - Triple Kill
    20003, -- Killing 4 in quick succession ( + 10s) - Ultra Kill
    20004 -- Killing 5 in quick succession ( + 10s) - Rampage
    },
    killStreak = {20005, -- Killing Spree (3 kills in one life)
    20006, -- Dominating (4 kills in one life)
    20007, -- Mega Kill (5 kills in one life)
    20008, -- Unstoppable (6 kills in one life)
    20009, -- Wicked Sick (7 kills in one life)
    20010, -- Monster Kill (8 kills in one life)
    20011, -- GODLIKE! (9 kills in one life)
    20012, -- BEYOND GODLIKE!!!! (10 kills in one life)
    20013}
}
local strings = {
    multiKill = {"|cffffffff with a |r|cffFFFFFFDOUBLE KILL|r", "|cffffffff with a |r|cffFFFFFFTRIPLE KILL|r",
                 "|cffffffff with an |r|cffFFFFFFULTRA KILL|r", "|cffFF0000RAMPAGE|r"},
    killStreak = {"|cffffffff is on a|r |cff00FF00killing spree|r", "|cffffffff is|r |cff8000FFdominating|r",
                  "|cffffffff is on a|r |cffFF00BFmega kill|r", "|cffffffff is|r |cffDF7401unstoppable|r",
                  "|cffffffff is|r |cffDBA901wicked sick|r", "|cffffffff is on a|r |cffFE2EF7monster kill|r",
                  "|cffffffff is|r |cffFF0000GODLIKE|r",
                  "|cffffffff is beyond|r |cffFFBF00GODLIKE, someone kill them!!|r"},
    colorClass = {
        [1] = "|cffC79C6E", -- Warrior
        [2] = "|cffF58CBA", -- Paladin
        [3] = "|cffABD473", -- Hunter
        [4] = "|cffFFF569", -- Rogue
        [5] = "|cffFFFFFF", -- Priest
        [6] = "|cffC41F3B", -- Death Knight
        [7] = "|cff0070DE", -- Shaman
        [8] = "|cff69CCF0", -- Mage
        [9] = "|cff9482C9", -- Warlock
        [11] = "|cffFF7d0A" -- Druid
    }
}
local function SaveKills(instanceId, plGUID, time)
    if BG[instanceId].Killer[plGUID] then
        if BG[instanceId].Killer[plGUID].Kill >= 1 then
            BG[instanceId].Killer[plGUID].Kill = BG[instanceId].Killer[plGUID].Kill + 1
            if (time - BG[instanceId].Killer[plGUID].Time) <= 10 then
                BG[instanceId].Killer[plGUID].KillTemp = BG[instanceId].Killer[plGUID].KillTemp + 1
            else
                BG[instanceId].Killer[plGUID].KillTemp = 1
            end
            BG[instanceId].Killer[plGUID].Time = time
        else
            BG[instanceId].Killer[plGUID] = {
                Kill = 1,
                Time = time,
                KillTemp = 1
            }
        end
    else
        BG[instanceId].Killer[plGUID] = {
            Kill = 1,
            Time = time,
            KillTemp = 1
        }
    end
end
local function ResetKills(instanceId, plGUID)
    BG[instanceId].Killer[plGUID] = {
        Kill = 0,
        Time = 0,
        KillTemp = 0
    }
end
local function SendSoundKillStreak(eventid, delay, repeats, player)
    if BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].Kill > 2 then
        local Players = player:GetMap():GetPlayers(2)
        for i = 1, #Players do
            if BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].Kill < 10 then
                Players[i]:PlayDirectSound(
                    sounds.killStreak[BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].Kill] - 2, Players[i])
            else
                Players[i]:PlayDirectSound(sounds.killStreak[8], Players[i])
            end
        end
    end
end
local function SendSoundMultiKill(eventid, delay, repeats, player)
    if BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].KillTemp >= 2 then
        local Players = player:GetMap():GetPlayers(2)
        for i = 1, #Players do
            if BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].KillTemp < 5 then
                Players[i]:PlayDirectSound(sounds.multiKill[BG[player:GetInstanceId()].Killer[player:GetGUIDLow()]
                                               .KillTemp - 1], Players[i])
            else
                Players[i]:PlayDirectSound(sounds.multiKill[4], Players[i])
            end
        end
    end
end
local function SendNotificationKill(eventid, delay, repeats, player)
    local msg
    if BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].KillTemp == 2 and
        BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].Kill < 3 then
        msg = strings.colorClass[player:GetClass()] .. player:GetName() .. "|r|cffffffff got a DOUBLE KILL|r"
    elseif BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].Kill > 2 then
        if BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].Kill < 10 then
            msg = strings.colorClass[player:GetClass()] .. player:GetName() .. "|r " ..
                      strings.killStreak[BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].Kill - 2]
        else
            msg = strings.colorClass[player:GetClass()] .. player:GetName() .. "|r " .. strings.killStreak[8]
        end
        if BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].KillTemp > 1 then
            if BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].KillTemp < 5 then
                msg = msg .. "\n" ..
                          strings.multiKill[BG[player:GetInstanceId()].Killer[player:GetGUIDLow()].KillTemp - 1]
            else
                msg = msg .. "\n" .. strings.multiKill[4]
            end
        end
    end
    if msg then
        local Players = player:GetMap():GetPlayers(2)
        for i = 1, #Players do
            Players[i]:SendNotification(msg)
        end
    end
end
local function StarBG(event, bg, bgId, instanceId)
    BG[instanceId] = {
        FirstBlood = false,
        Killer = {}
    }
end
RegisterBGEvent(1, StarBG)  
local function KillPlayer(event, killer, killed)
    local instanceId = killer:GetInstanceId()
    if killer:GetMap():IsBattleground() and not BG[instanceId].FirstBlood then
        local Players = killer:GetMap():GetPlayers(2)
        for i = 1, #Players do
            Players[i]:PlayDirectSound(sounds.firstblood, Players[i])
            Players[i]:SendNotification(strings.colorClass[killer:GetClass()] .. killer:GetName() ..
                                            "|r |cffffffffdrew first blood by killing|r " ..
                                            strings.colorClass[killed:GetClass()] .. killed:GetName() .. "|r")
        end
        SaveKills(instanceId, killer:GetGUIDLow(), GetGameTime())
        BG[instanceId].FirstBlood = true
    elseif killer:GetMap():IsBattleground() then
        SaveKills(instanceId, killer:GetGUIDLow(), GetGameTime())
        ResetKills(killed:GetInstanceId(), killed:GetGUIDLow())
        killer:RegisterEvent(SendNotificationKill, 0)
        killer:RegisterEvent(SendSoundKillStreak, 0)
        killer:RegisterEvent(SendSoundMultiKill, 800)
    end
end
RegisterPlayerEvent(6, KillPlayer)

