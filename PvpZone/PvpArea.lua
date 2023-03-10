--[[
    Convierte areas en Areas FFA.
]]

local areaId = { 268 }

local function OnEnterArea(event, player, newZone, newArea)
    for i, v in ipairs(areaId) do
        if v == newArea then
            player:SetFFA(true)
        end
    end
    
end

RegisterPlayerEvent( 27, OnEnterArea )