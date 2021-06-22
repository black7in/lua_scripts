local cmd = "refresh"

local function OnCommand(event, player, command)
    if command == cmd then
        if not player:IsInCombat() then
            player:SetHealth( player:GetMaxHealth() )
            player:SetPower( player:GetMaxPower( 0 ), 0 )
            player:ResetAllCooldowns()
        else
            player:SendNotification("Estas en combate!")
        end
        return false
    end
end RegisterPlayerEvent( 42, OnCommand )