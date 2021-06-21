--[[
    WorlChat para Trinitycore y Azerothcore
    Desarrollador por Black7in.
]]
local ChatPrefix = "chat "
local ChannelName = "World"

local faction = {
	"|TInterface/icons/Inv_Misc_Tournaments_banner_Human.png:13|t",
	"|TInterface/icons/Inv_Misc_Tournaments_banner_Orc.png:13|t"
}
local class = {
    "|TInterface\\icons\\INV_Sword_27.png:13|t",
	"|TInterface\\icons\\INV_Hammer_01.png:13|t",
	"|TInterface\\icons\\INV_Weapon_Bow_07.png:13|t",
	"|TInterface\\icons\\INV_ThrowingKnife_04.png:13|t",
	"|TInterface\\icons\\INV_Staff_30.png:13|t",
	"|TInterface\\icons\\Spell_Deathknight_ClassIcon.png:13|t",
	"|TInterface\\icons\\inv_jewelry_talisman_04.png:13|t",
	"|TInterface\\icons\\Spell_MageArmor.png:13|t",
	"|TInterface\\icons\\Spell_Nature_FaerieFire:13|t",
	"",
	"|TInterface\\icons\\Ability_Druid_Maul.png:13|t",
}
local race = {
    [1] = {
        "|TInterface/ICONS/Achievement_Character_Human_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Orc_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Dwarf_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Nightelf_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Undead_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Tauren_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Gnome_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Troll_Male:13|t",
        "",
        "|TInterface/ICONS/Achievement_Character_Bloodelf_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Draenei_Male:13|t", 
    },
    [2] = {
        "|TInterface/ICONS/Achievement_Character_Human_Female:13|t",
	    "|TInterface/ICONS/Achievement_Character_Orc_Female:13|t",
	    "|TInterface/ICONS/Achievement_Character_Dwarf_Female:13|t",
	    "|TInterface/ICONS/Achievement_Character_Nightelf_Female:13|t",
	    "|TInterface/ICONS/Achievement_Character_Undead_Female:13|t",
	    "|TInterface/ICONS/Achievement_Character_Tauren_Female:13|t",
	    "|TInterface/ICONS/Achievement_Character_Gnome_Female:13|t",
	    "|TInterface/ICONS/Achievement_Character_Troll_Female:13|t",
	    "",
	    "|TInterface/ICONS/Achievement_Character_Bloodelf_Female:13|t",
	    "|TInterface/ICONS/Achievement_Character_Draenei_Female:13|t",
    }
}
local gm = "|TINTERFACE/CHATFRAME/UI-CHATICON-BLIZZ:13|t"

local color = {
    "|cffC79C6E", 
    "|cffF58CBA", 
    "|cffABD473", 
    "|cffFFF569", 
    "|cffFFFFFF", 
    "|cffC41F3B", 
    "|cff0070DE", 
    "|cff40C7EB", 
    "|cff8787ED", 
    "", 
    "|cffFF7D0A",
}

local function OnCommand(event, player, command)
    if command:sub(1, ChatPrefix:len())  == ChatPrefix then
        local msg
        if player:IsGM() then
            msg = "|cff00FF00["..ChannelName.."]["..gm.."][|cffFFFFFF"..player:GetName().."|r|cff00FF00]|r: "..command:sub(ChatPrefix:len()+1)
        else
            msg = "|cff00FF00["..ChannelName.."]["..faction[player:GetTeam()+1].."]["..race[player:GetGender()+1][player:GetRace()].."]["..class[player:GetClass()].."]["..color[player:GetClass()]..player:GetName().."|r|cff00FF00]|r: "..command:sub(ChatPrefix:len()+1)
        end
        SendWorldMessage(msg)
        return false
    end
end RegisterPlayerEvent( 42, OnCommand )