--[[
    Agrega a una hermandad a tus jugadores nuevos, es importante que las hermandades estén previamentes creadas.
]]

local guild = {
    "Jugadores Nuevos Alianza", -- Team Alliance
    "Jugadores Nuevos Horda" -- Team Horde
}

local function OnFirstLogin(event, player)
    local g = GetGuildByName( guild[player:GetTeam()+1] )
    if g then
        g:AddMember( player, 0 )
    end
end RegisterPlayerEvent( 30, OnFirstLogin )