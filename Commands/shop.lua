local cmd = "shop"

local function OnCommand(event, player, command)
    if command == cmd then
        if not player:IsInCombat() then
            player:Teleport( 571, 5804.15, 624.771, 647.767, 1.64 ) -- Dalaran
        else
            player:SendNotification("Estas en combate!")
        end
        return false
    end
end RegisterPlayerEvent( 42, OnCommand )