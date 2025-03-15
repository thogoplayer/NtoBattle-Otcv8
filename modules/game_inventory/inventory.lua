InventorySlotStyles = {
  [InventorySlotHead] = "HeadSlot",
  [InventorySlotNeck] = "NeckSlot",
  [InventorySlotBack] = "BackSlot",
  [InventorySlotBody] = "BodySlot",
  [InventorySlotRight] = "RightSlot",
  [InventorySlotLeft] = "LeftSlot",
  [InventorySlotLeg] = "LegSlot",
  [InventorySlotFeet] = "FeetSlot",
  [InventorySlotFinger] = "FingerSlot",
  [InventorySlotAmmo] = "AmmoSlot"
}

Backgrounds = 
{
[0] = { path = '/images/inventory/inventory.png', id = 'background_anbu'},
[1] = { path = '/images/inventory/Maito_INV.png', id = 'background_uchiha'},
[2] = { path = '/images/inventory/Inuzuka_INV.png', id = 'background_hyuuga'},
[3] = { path = '/images/inventory/Aburame_INV.png', id = 'background_aburame'},
[4] = { path = '/images/inventory/Hyuuga_INV.png', id = 'background_nara'},
[5] = { path = '/images/inventory/Uchiha_INV.png', id = 'background_inuzuka'},
[6] = { path = '/images/inventory/Nara_INV.png', id = 'background_akimichi'},
[7] = { path = '/images/inventory/Akimichi_INV.png', id = 'background_maito'},
[8] = { path = '/images/inventory/Uchiha_INV.png', id = 'background_uchiha'},
}


inventoryWindow = nil
inventoryPanel = nil
inventoryButton = nil

function init()
  local protocol = g_game.getProtocolGame()
  if protocol then
  protocol:sendExtendedOpcode(26, "haha")
  end
  connect(LocalPlayer, { onInventoryChange = onInventoryChange })
  connect(g_game, { onGameStart = refresh })
  connect(g_game, { onGameEnd = offline })

  g_keyboard.bindKeyDown('Ctrl+I', toggle)

  inventoryButton = modules.client_topmenu.addLeftGameToggleButton('inventoryButton', tr('Inventory') .. ' (Ctrl+I)', '/images/topbuttons/inventory', toggle)
  inventoryButton:setOn(true)
  inventoryWindow = g_ui.loadUI('inventory', modules.game_interface.getRightPanel())
  inventoryWindow:disableResize()
  inventoryPanel = inventoryWindow:getChildById('contentsPanel')

  


  connect(LocalPlayer, { onOutfitChange = onOutfitChange })
  
  local itemWidget = inventoryPanel:getChildById('slot9')
  itemWidget:setVisible(true)

  --local fightOffensiveBox = inventoryWindow:recursiveGetChildById('fightOffensiveBox')
  --itemWidget:setVisible(true)
 -- local itemWidget = inventoryPanel:getChildById('slot10')
  --itemWidget:setVisible(false)
           
  refresh()
  inventoryWindow:setup()
  refresh()
  inventoryWindow:open()
    inventoryButton:setOn(false)
    
end

function terminate()
  disconnect(LocalPlayer, { onInventoryChange = onInventoryChange })
  disconnect(g_game, { onGameStart = refresh })


  g_keyboard.unbindKeyDown('Ctrl+I')

  inventoryWindow:destroy()
  inventoryButton:destroy()
end



function refresh()
  local protocolGame = g_game.getProtocolGame()
  if protocolGame then
  protocolGame:sendExtendedOpcode(26)
  end



  local player = g_game.getLocalPlayer()
  for i=InventorySlotFirst,InventorySlotLast do
    if g_game.isOnline() then
      onInventoryChange(player, i, player:getInventoryItem(i))
    else
      onInventoryChange(player, i, nil)
    end
  end

end


function toggle()
  if inventoryButton:isOn() then
    inventoryWindow:close()
    inventoryButton:setOn(false)
  else
    inventoryWindow:open()
    inventoryButton:setOn(true)
  end
  refresh()
end

function onMiniWindowClose()
  inventoryButton:setOn(false)
end


-- hooked events
function onInventoryChange(player, slot, item, oldItem)
  if slot >= InventorySlotPurse then return end
  local itemWidget = inventoryPanel:getChildById('slot' .. slot)
  if not itemWidget then return end
  if item then
    itemWidget:setStyle('Item')
    itemWidget:setItem(item)
  else
    itemWidget:setStyle(InventorySlotStyles[slot])
    itemWidget:setItem(nil)
  end
end

ProtocolGame.registerExtendedOpcode(26, function (protocol, opcode, buffer)
    local vocation = tonumber(buffer)
    if vocation and vocation ~= 0 then
    inventoryWindow:setImageSource(Backgrounds[vocation].path)
    end 
end)