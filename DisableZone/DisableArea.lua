--[[
    Restringir la entrada de jugadores a un Area.
]]

local areaId = { 268, 3817 }

local function OnEnterArea(event, player, newZone, newArea)
    for i, v in ipairs(areaId) do
        if v == newArea and not player:IsGM() then
            player:CastSpell( player, 8690, true )
            player:SendNotification("Area no disponible para jugadores!")
        end
    end
    
end

RegisterPlayerEvent( 27, OnEnterArea )