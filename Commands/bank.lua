local cmd = "bank"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendShowBank( player )
        return false
    end
end RegisterPlayerEvent( 42, OnCommand )