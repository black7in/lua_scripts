--[[
    UPDATE `item_template` SET `name` = 'Worgen Shard', `Quality` = 4, `spellid_1` = 73835, `spellcooldown_1` = 1000, `bonding` = 1, `description` = 'Transforms you into a speedy worgen.' WHERE (`entry` = 33146);
]]

local displayId = 657
local itemId = 33146
local speedId = 59737

local function OnItemUse( event, player, item, target )
    if not player:IsInCombat() then
        if player:GetDisplayId() == displayId  or player:GetAura( speedId ) then
        player:DeMorph()
        player:RemoveAura( speedId )
        else
            player:SetDisplayId( displayId )
         player:AddSpeed()
        end
        player:CastSpell( player, 71495, true )
    else
        player:SendNotification("You are in combat!")
    end
end
RegisterItemEvent( itemId, 2, OnItemUse )

local function OnLogin( event, player )
    if player:HasAura(speedId) and player:GetDisplayId() ~= displayId then
        player:RemoveAura( speedId )
    end
end

RegisterPlayerEvent( 3, OnLogin )

local function OnEnterCombat( event, player, enemy )
    if player:GetDisplayId() == displayId  or player:GetAura( speedId ) then
        player:DeMorph()
        player:RemoveAura( speedId )
    end
end
RegisterPlayerEvent( 33, OnEnterCombat )


function Player:AddSpeed( )
    self:AddAura(speedId, self)
    local aura = self:GetAura( speedId )
    aura:SetDuration( 3600000 )
end