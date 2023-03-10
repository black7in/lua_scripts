--[[
    Restringir la entrada de jugadores a una Zona.
]]

local zoneId = { 268, 876 }

local function OnEnterZone(event, player, newZone, newArea)
    for i, v in ipairs(zoneId) do
        if v == newZone and not player:IsGM() then
            player:CastSpell( player, 8690, true )
            player:SendNotification("Zona no disponible para jugadores!")
        end
    end
    
end

RegisterPlayerEvent( 27, OnEnterZone )