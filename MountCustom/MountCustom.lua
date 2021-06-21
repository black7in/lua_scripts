--[[
    [LUA] MountCustom Trinitycore/Azerothcore 3.3.5a
    Discord: elperroblack#3720
]]
local MountCustom = {
    itemCast   = { 16343, 37709, 31469, 30325, 39149,  28025, 18967, 16344, 23982},
    modelMount = { 29673, 29079, 28871, 1284 ,  1082,  31381, 18722, 4424 ,   616},
}
local id
function MountCustom.Test(event, player, item, target)
        id = item:GetEntry()
        player:RegisterEvent(MountCustom.CastSpell, 1)
end
function MountCustom.CastSpell(eventid, delay, repeats, player)
    player:CastSpell(player, 46980, false)
end
for i = 1, #MountCustom.itemCast, 1 do
    RegisterItemEvent( MountCustom.itemCast[i], 2, MountCustom.Test )
end
function MountCustom.IFCastSpell(event, player, spell, skipCheck)
    if spell:GetEntry() == 46980 then
        player:RegisterEvent(MountCustom.AddMount, 0)
    end
end
RegisterPlayerEvent(5, MountCustom.IFCastSpell)
function MountCustom.AddMount(eventid, delay, repeats, player)
    player:MountCustoms()
end
function Player:MountCustoms()
    for i = 1, #MountCustom.itemCast, 1 do
        if MountCustom.itemCast[i] == id then
            self:Mount(MountCustom.modelMount[i])
        end
    end
end
