--[[
    [LUA] CustomMount Trinitycore/Azerothcore 3.3.5a
    Black
]]

local CustomMount = {
    itemCast   = { 16343, 37709, 31469, 30325, 39149,  28025, 18967, 16344, 23982},
    modelMount = { 29673, 29079, 28871, 1284 ,  1082,  31381, 18722, 4424 ,   616},
}
local id
function CustomMount.Test(event, player, item, target)
        id = item:GetEntry()
        player:RegisterEvent(CustomMount.CastSpell, 1)
end
function CustomMount.CastSpell(eventid, delay, repeats, player)
    player:CastSpell(player, 46980, false)
end
for i = 1, #CustomMount.itemCast, 1 do
    RegisterItemEvent( CustomMount.itemCast[i], 2, CustomMount.Test )
end
function CustomMount.IFCastSpell(event, player, spell, skipCheck)
    if spell:GetEntry() == 46980 then
        player:RegisterEvent(CustomMount.AddMount, 0)
    end
end
RegisterPlayerEvent(5, CustomMount.IFCastSpell)
function CustomMount.AddMount(eventid, delay, repeats, player)
    player:CustomMount()
end
function Player:CustomMount()
    for i = 1, #CustomMount.itemCast, 1 do
        if CustomMount.itemCast[i] == id then
            self:Mount(CustomMount.modelMount[i])
        end
    end
end
