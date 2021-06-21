--[[
    Entrenador de clase para nivel 80, con un solo click aprende todos los hechizos!.
    Desarrollador por Black7in.
]]
local Spells = require("Spells")

local Trainer = 11940 -- Entry npc

local function OnGossipHello(event, player, creature)
    if player:GetLevel() >= 80 then
        player:GossipMenuAddItem(1, "|TInterface/ICONS/Ability_Mage_FieryPayback:28:28:-15:0|t Aprender todos los hechizos", 0, 1)
        if player:GetSpecsCount() == 1 then 
            player:GossipMenuAddItem(1, "|TInterface/ICONS/Ability_Marksmanship:28:28:-15:0|t Aprender doble especializacion", 0, 2)
        end
        player:GossipMenuAddItem(1, "|TInterface/ICONS/Trade_Engineering:28:28:-15:0|t Reiniciar talentos", 0, 3)   
        player:GossipMenuAddItem(1, "|TInterface/ICONS/Achievement_Reputation_06:28:28:-15:0|t No quiero nada.", 0, 4) 
        player:GossipSendMenu(1, creature)
    else
        player:SendNotification("Necesitas ser nivel 80")
    end
end
local function OnGossipSelect(event, player, creature, sender, intid, code, menu_id)
    if intid == 1 then
        player:LearnAllSpells()
        player:CastSpell(player, 47292, true)
        player:GossipComplete()
        player:SendBroadcastMessage("Aprendiste todos tus hechizos!.")
    elseif intid == 2 then
        player:CastSpell(player, 63624, false)
        player:CastSpell(player, 63680, false)
        player:CastSpell(player, 47292, true)
        player:SendBroadcastMessage("Aprendiste doble especialización!.")
        player:GossipComplete()
    elseif intid == 3 then
        player:ResetTalents()
        player:GossipComplete()
        player:SendBroadcastMessage("Reiniciaste tus talentos!.")
    end
    if intid == 4 then
        player:GossipComplete()
        creature:SendUnitWhisper("Vuelve pronto.", 0, player)
    end
end
RegisterCreatureGossipEvent( Trainer, 1, OnGossipHello )
RegisterCreatureGossipEvent( Trainer, 2, OnGossipSelect )