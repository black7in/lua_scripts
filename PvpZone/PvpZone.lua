--[[
    Convierte zonas en Zonas FFA.
]]

local zoneId = { 268 }

local function OnEnterZone(event, player, newZone, newArea)
    for i, v in ipairs(zoneId) do
        if v == newZone then
            player:SetFFA(true)
        end
    end
    
end

RegisterPlayerEvent( 27, OnEnterZone )