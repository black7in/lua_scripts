--[[
    Probador de monturas! por unos cuantos segundos, puede modificar la lista a su antojo.
    Desarrollado por Black7in.
]]
local npc = 11940
local maxGossip = 10

local monturas = {
    [1000001] = { -- Monturas Terrestres
        [1] = {48778, "|TINTERFACE/ICONS/Spell_deathknight_summondeathcharger:28:28:-15:0|tDestrero de la muerte de Archerus"},
        [2] = {16056, "|TINTERFACE/ICONS/ability_mount_whitetiger:28:28:-15:0|tSable de hielo anciano"},
        [3] = {16081, "|TINTERFACE/ICONS/Ability_mount_whitedirewolf:28:28:-15:0|tLobo invernal"},
        [4] = {66906, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tDestero argenta"},
        [5] = {51412, "|TINTERFACE/ICONS/Ability_druid_challangingroar:28:28:-15:0|tOso de batalla grande"},
        [6] = {22719, "|TINTERFACE/ICONS/Ability_mount_mechastrider:28:28:-15:0|tZancudo de batalla negro"},
        [7] = {25863, "|TINTERFACE/ICONS/inv_misc_qirajicrystal_05:28:28:-15:0|tTanque de batalla quiraji negro"},
        [8] = {17461, "|TINTERFACE/ICONS/ability_mount_mountainram:28:28:-15:0|tCarnero negro"},
        [9] = {59799, "|TINTERFACE/ICONS/Ability_mount_mammoth_white:28:28:-15:0|tMamut de hielo"},
        [10] = {65639, "|TINTERFACE/ICONS/Ability_mount_cockatricemountelite_purple:28:28:-15:0|tHálcon azul rojo presto"},
        [11] = {22722, "|TINTERFACE/ICONS/ability_mount_undeadhorse:28:28:-15:0|tCaballo de guerra esqueletico rojo"},
        [12] = {23510, "|TINTERFACE/ICONS/ability_mount_mountainram:28:28:-15:0|tCarnero de batalla pico tormenta"},
        -- etc
    },
    [1000002] = { -- Monturas Voladoras 
        [1] = {60025, "|TINTERFACE/ICONS/ability_mount_drake_blue:28:28:-15:0|tDraco albino"},
        [2] = {63844, "|TINTERFACE/ICONS/ability_mount_warhippogryph:28:28:-15:0|tHipogrifo argenta"},
        [3] = {61230, "|TINTERFACE/ICONS/Ability_mount_swiftpurplewindrider:28:28:-15:0|tJinete del viento azul acorazado"},
        [4] = {59567, "|TINTERFACE/ICONS/ability_mount_drake_blue:28:28:-15:0|tDraco azul"},
        [5] = {59650, "|TINTERFACE/ICONS/ability_mount_drake_twilight:28:28:-15:0|tDraco negro"},
        [6] = {59976, "|TINTERFACE/ICONS/ability_mount_drake_proto:28:28:-15:0|tProtodraco negro"},
        [7] = {72808, "|TINTERFACE/ICONS/ability_mount_redfrostwyrm_01:28:28:-15:0|tVencedor razaescarcha"},
        [8] = {61996, "|TINTERFACE/ICONS/ability_hunter_pet_dragonhawk:28:28:-15:0|tDracohálcon azul"},

    },
    [1000003] = { -- Monturas Exoticas Ability_druid_challangingroar
        [1] = {43688, "|TINTERFACE/ICONS/Ability_druid_challangingroar:28:28:-15:0|tOso de guerra Amani"},
        [2] = {40192, "|TINTERFACE/ICONS/inv_misc_summerfest_brazierorange:28:28:-15:0|tCenizas de Al'ar"},
        [3] = {58983, "|TINTERFACE/ICONS/ability_mount_bigblizzardbear:28:28:-15:0|tGran oso de Blizzard"},
        [4] = {71342, "|TINTERFACE/ICONS/inv_valentinepinkrocket:28:28:-15:0|tGran cohete de amor"},
        [5] = {74856, "|TINTERFACE/ICONS/ability_mount_warhippogryph:28:28:-15:0|tHipogrifo llameante"},
        [6] = {72286, "|TINTERFACE/ICONS/ability_mount_pegasus:28:28:-15:0|tInvencible"},
        [7] = {65917, "|TINTERFACE/ICONS/inv_egg_03:28:28:-15:0|tGallo magico"},
        [8] = {64731, "|TINTERFACE/ICONS/inv_misc_fish_turtle_02:28:28:-15:0|tTortuga marina"},
    },
}
local function GenerarMultiMenu(player, creature, sender, intid, type)
    local min = (maxGossip * sender) - maxGossip + 1
    local max = maxGossip * sender
    if max > #monturas[type] then
        max = #monturas[type]
    end
    for i = min, max, 1 do
        player:GossipMenuAddItem(1, monturas[type][i][2], 0, monturas[type][i][1])
    end
    if max < #monturas[type] then
        player:GossipMenuAddItem(1, "|TINTERFACE/Buttons/UI-SpellbookIcon-NextPage-Up:38:38:-20:5|tSiguiente", sender, type)
    end
    if sender > 1 then
        player:GossipMenuAddItem(1, "|TINTERFACE/Buttons/UI-SpellbookIcon-PrevPage-Up:38:38:-20:5|tAnterior", sender-2, type)
    end
    player:GossipSendMenu(1, creature, 1)
end

local function PlayerDismount(eventid, delay, repeats, player)
    player:Dismount()
end

local function OnGossipHello(event, player, object)
    player:GossipClearMenu()
    player:GossipMenuAddItem( 0, "|TINTERFACE/ICONS/ability_mount_charger:28:28:-15:0|tMonturas Terrestres", 0, 1000001 )
    player:GossipMenuAddItem( 0, "|TINTERFACE/ICONS/spell_frost_arcticwinds:28:28:-15:0|tMonturas Voladoras", 0, 1000002 )
    player:GossipMenuAddItem( 0, "|TINTERFACE/ICONS/ability_mount_celestialhorse:28:28:-15:0|tMonturas Exóticas", 0, 1000003 )
    player:GossipSendMenu( 1, object )
end RegisterCreatureGossipEvent( npc, 1, OnGossipHello )

local function OnGossipSelect(event, player, object, sender, intid, code, menu_id)
    if intid > 1000000 then
        GenerarMultiMenu(player, object, sender + 1, intid, intid)
    else
        player:Dismount()
        player:RemoveEvents()
        object:AddAura(intid, player)
        player:RegisterEvent( PlayerDismount, 5000 )
        OnGossipHello(event, player, object)
    end
end RegisterCreatureGossipEvent( npc, 2, OnGossipSelect )

local function CheckMount(event, player)
    if player:IsMounted() then
        for i = 1, #monturas[1000001] do
            if player:HasAura(monturas[1000001][i][1]) and not player:HasSpell(monturas[1000001][i][1]) then
                player:Dismount()
            end
        end
        for i = 1, #monturas[1000002] do
            if player:HasAura(monturas[1000001][i][1]) and not player:HasSpell(monturas[1000002][i][1]) then
                player:Dismount()
            end
        end
        for i = 1, #monturas[1000003] do
            if player:HasAura(monturas[1000003][i][1]) and not player:HasSpell(monturas[1000003][i][1]) then
                player:Dismount()
            end
        end
    end
end RegisterPlayerEvent( 3, CheckMount )