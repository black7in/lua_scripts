--[[
    LoginAnnounce for Azerothcore and Trinitycore Eluna 3.3.5a
    Discord: elperroblack#6996
]]

local GameMasterAnnouncement = true -- false = Ignore GameMasters
local strings = {
    serverName = "LoginAnnouncer  ",
    faction = {
        [0] = "|cff0000FFAlliance|r",
        [1] = "|cffFF0000Horde|r"
    },
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
local icons = {
    faction = {
        [0] = "|TInterface/icons/Inv_Misc_Tournaments_banner_Human:13|t", -- Alliance
        [1] = "|TInterface/icons/Inv_Misc_Tournaments_banner_Orc:13|t" -- Horde
    },
    gameMaster = "|TInterface/icons/Mail_GMIcon:13:20|t", -- GameMaster
    logo = "|TInterface/ICONS/Temp:15|t " -- Logo World of Warcraft
}

local function LoginAnnouncer(eventid, delay, repeats, player)
    local msg
    if GameMasterAnnouncement and player:GetGMRank() >= 1 then
            msg = icons.logo ..strings.serverName ..icons.gameMaster .."|cff2ECCFA" ..player:GetName() .."|r " .. "is online.|r"
    else
        if player:GetGMRank() < 1 then
            msg = icons.logo ..strings.serverName ..icons.faction[player:GetTeam()] ..strings.colorClass[player:GetClass()] ..player:GetName() .."|r "  .."is online.|r"
        end
    end
    if msg then
        SendWorldMessage(msg)
    end
end

local function OnLogin(event, player)
    player:RegisterEvent(LoginAnnouncer, 3000)
end
RegisterPlayerEvent(3, OnLogin)