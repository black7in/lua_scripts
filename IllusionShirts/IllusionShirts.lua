--[[
    Camisas ilusión, puede agregar mas camisas en la lista.
    Desarrollado por Black7in.
]]
local Shirt = {
    --   entryShirt,      DisplayId
    [1] = {42360,           22235}, -- Arthas
    [2] = {42361,           21105}, -- Broken
    [3] = {42363,           21267}, -- Vil Orc
    [4] = {42365,           20582}, -- Goblin
}

local CMSG_SWAP_INV_ITEM = 0x10D

function Shirt.EquipItem(event, player, item, bag, slot)
    if item:GetSlot() == 3 then
        for i, v in ipairs(Shirt) do
            if item:GetEntry() == v[1] then
                player:SetDisplayId( v[2] )
                return
            end
        end
        for i, v in ipairs(Shirt) do
            if player:GetDisplayId() == v[2] then
                player:DeMorph()
                return
            end
        end

    end
end RegisterPlayerEvent( 29, Shirt.EquipItem )

function Shirt.OnPacketSend(event, packet, player) -- No modificar, puede crashear el servidor si hace algo mal.
    local srcslot = packet:ReadByte()
    local slot = packet:ReadByte()
    if slot == 3 then
        local item = player:GetItemByPos( 255, slot )
        if item then
            for i, v in ipairs(Shirt) do
                if item:GetEntry() == v[1] then
                    if player:GetDisplayId() == v[2] then
                        player:DeMorph()
                        break
                    end
                end
            end 
        end
    end
end RegisterPacketEvent( CMSG_SWAP_INV_ITEM, 7, Shirt.OnPacketSend )