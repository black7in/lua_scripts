local RL = {}
RL.Rewards = { 
--        {lvl,     reward,      amount,    gold            icon} -- If you want to increase more rewards you can do so respecting the format
    [1] = {10,      29736,           1,     100,          "|TINTERFACE/ICONS/inv_misc_rune_05:30:30:0:0|t"},
    [2] = {20,      29736,           2,     100,          "|TINTERFACE/ICONS/inv_misc_rune_05:30:30:0:0|t"},
    [3] = {30,      29736,           3,     100,          "|TINTERFACE/ICONS/inv_misc_rune_05:30:30:0:0|t"},
    [4] = {40,      29736,           4,     100,          "|TINTERFACE/ICONS/inv_misc_rune_05:30:30:0:0|t"},
    [5] = {50,      29736,           5,     1000,          "|TINTERFACE/ICONS/inv_misc_rune_05:30:30:0:0|t"},
    [6] = {60,      29736,           6,     100,          "|TINTERFACE/ICONS/inv_misc_rune_05:30:30:0:0|t"},
    [7] = {70,      29736,           7,     100,          "|TINTERFACE/ICONS/inv_misc_rune_05:30:30:0:0|t"},
    [8] = {80,      29736,           8,     100,          "|TINTERFACE/ICONS/inv_misc_rune_05:30:30:0:0|t"}
}

function RL.ChangeLevel(event, player, oldLevel)
    for i, v in ipairs(RL.Rewards) do
        if v[1] == player:GetLevel() then
            RL.SendReward(player, v[2], v[3], v[4], v[5])
            break
        end
    end
end RegisterPlayerEvent( 13, RL.ChangeLevel )

function RL.SendReward(player, reward, amount, gold, icon)
    local msg = "|cFFFF0000=====================\n"
    .."|cFFFFA500Recompenza por nivel "..player:GetLevel().."\n"
    .."|cFFFF0000=====================\n\n"
    .."|cFF2E8B57Recibiste:|r\n\n"
    .."     "..icon.."\n"
    .."     "..GetItemLink( reward, 6 ).." x"..amount.."\n"
    .."      Oro: "..gold.."\n"
    .."Revisa tu buzón de correo."
    local money = gold * 10000
    SendMail( "Subject", "Congratulations", player:GetGUIDLow(), 1, 61, 0, money, 0, reward, amount )
    player:GossipClearMenu()
    player:GossipMenuAddItem(1, "", 0, 1, false, msg)
    player:GossipSendMenu(1, player, 0)
end