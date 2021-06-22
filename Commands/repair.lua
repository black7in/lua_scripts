local cmd = "repair"

local function OnCommand(event, player, command)
    if command == cmd then
        player:DurabilityRepairAll( false )
        return false
    end
end RegisterPlayerEvent( 42, OnCommand )