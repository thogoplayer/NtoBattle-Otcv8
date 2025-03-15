-- Criado por Thalles Vitor --
-- Sistema de Auto Loot --

local autoloot = g_ui.displayUI("autoloot")
local combobox = autoloot:getChildById("options")
local panel = autoloot:getChildById("panel_loots")
local panel_items = autoloot:getChildById("panel_loots_added")

local power = autoloot:getChildById("power_on")
local pesquisar = autoloot:getChildById("pesquisar")

local autolootbtn = nil
local optionss = {} -- default not inserted the values in combo-box
local itemlist = {} -- default not inserted the items in the list

function init()
  connect(g_game, {
    onGameStart = naoexibir,
    onGameEnd = naoexibir,
  })

  autolootbtn = modules.client_topmenu.addLeftGameToggleButton('autoloot', tr('Auto-Loot'), 'aloot', exibir)
  autolootbtn:setWidth(32)
  autolootbtn:setOn(false)

  autoloot:hide()
end

function terminate()
  disconnect(g_game, {
    onGameStart = naoexibir,
    onGameEnd = naoexibir,
  })

  autolootbtn:setOn(false)
  autoloot:hide()

  panel_items:destroyChildren()
end

function exibir()
  if not g_game.isOnline() then
    return
  end

  if autoloot:isVisible() then
    autoloot:setOn(false)
    autoloot:hide()
  else
    autoloot:setOn(true)
    autoloot:show()

    pesquisar.onTextChange = function(self, value)
      if value == "" then
        g_game.getProtocolGame():sendExtendedOpcode(65, "none".."@"..combobox:getText().."@")
      else
        g_game.getProtocolGame():sendExtendedOpcode(65, value.."@"..combobox:getText().."@")
      end
    end

    -- Send the opcode to receive the options and the items of the primary option
    g_game.getProtocolGame():sendExtendedOpcode(53, "Items")
  end
end

function naoexibir()
  autoloot:hide()
  autolootbtn:setOn(false)

  panel_items:destroyChildren()
end

ProtocolGame.registerExtendedOpcode(170, function(protocol, opcode, buffer) -- receive auto loot options
  local param = buffer:split("@")
  local options = tostring(param[1])

  -- not allowed insert again in the list to the create news label to the combo-box
  if optionss[options] == 1 then
    return
  end

  combobox:addOption(options)
  combobox.onTextChange = function(self, value) 
    if not g_game.isOnline() then
      return
    end

    g_game.getProtocolGame():sendExtendedOpcode(54, tostring(value)) 
  end

  optionss[options] = 1
end)

ProtocolGame.registerExtendedOpcode(106, function(protocol, opcode, buffer) -- receive auto loot list
  local param = buffer:split("@")
  local item_id = tonumber(param[1])
  local item_name = tostring(param[2])
  local power_get = tostring(param[3])

  -- not allowed to create again the items and widgets in panel
  if itemlist[item_name] == 1 then
    return
  end

  local item = g_ui.createWidget("Item", panel)
  item:setId("item")
  item:setTooltip(item_name)

  item:setMarginLeft(5)
  item:setItemId(item_id)

  local label = g_ui.createWidget("ItemName", item)
  label:setId("nameItem")
  label:addAnchor(AnchorTop, "parent", AnchorTop)
  label:addAnchor(AnchorLeft, "parent", AnchorLeft)
  label:setText(item_name)

  local item_option = g_ui.createWidget("ItemOption", panel)
  item_option:setId("itemOption")
  item_option:setMarginTop(-30)
  item_option:setMarginBottom(40)
  item_option:setMarginLeft(210)
  item_option:setMarginRight(-200)

  item_option:setTooltip("Clique aqui para adicionar o item na lista.")
  item_option.onClick = function() 
    if not g_game.isOnline() then
      return
    end

    g_game.getProtocolGame():sendExtendedOpcode(55, tostring(item_name))
  end

  if power_get == "true" then
    power:setText("ON")
  else
    power:setText("OFF")
  end

  power.onClick = function() 
    if not g_game.isOnline() then
      return
    end

    if power:getText() == "OFF" then
      power:setText("ON")
      g_game.getProtocolGame():sendExtendedOpcode(57, "ligar")
    else
      power:setText("OFF")
      g_game.getProtocolGame():sendExtendedOpcode(57, "desligar")
    end
  end

  itemlist[item_name] = 1
end)

ProtocolGame.registerExtendedOpcode(107, function(protocol, opcode, buffer) -- destroy childrens
  local param = buffer:split("@")

  if param[1] == "destroy" then
    panel:destroyChildren()
  end

  if param[1] == "destroyAddedItem" then
    panel_items:destroyChildren()
  end
end)

ProtocolGame.registerExtendedOpcode(108, function(protocol, opcode, buffer) -- change auto loot category
  local param = buffer:split("@")
  local item_id = tonumber(param[1])
  local item_name = tostring(param[2])
  local power_get = tostring(param[3])

  local item = g_ui.createWidget("Item", panel)
  item:setId("item")
  item:setTooltip(item_name)

  item:setMarginLeft(5)
  item:setItemId(item_id)

  local label = g_ui.createWidget("ItemName", item)
  label:setId("nameItem")
  label:addAnchor(AnchorTop, "parent", AnchorTop)
  label:addAnchor(AnchorLeft, "parent", AnchorLeft)
  label:setText(item_name)

  local item_option = g_ui.createWidget("ItemOption", panel)
  item_option:setId("itemOption")
  item_option:setMarginTop(-30)
  item_option:setMarginBottom(40)
  item_option:setMarginLeft(210)
  item_option:setMarginRight(-200)

  item_option:setTooltip("Clique aqui para adicionar o item na lista.")
  item_option.onClick = function() 
    if not g_game.isOnline() then
      return
    end

    g_game.getProtocolGame():sendExtendedOpcode(55, tostring(item_name))
  end

  if power_get == "true" then
    power:setText("ON")
  else
    power:setText("OFF")
  end

  power.onClick = function() 
    if not g_game.isOnline() then
      return
    end

    if power:getText() == "OFF" then
      power:setText("ON")
      g_game.getProtocolGame():sendExtendedOpcode(57, "ligar")
    else
      power:setText("OFF")
      g_game.getProtocolGame():sendExtendedOpcode(57, "desligar")
    end
  end
end)

ProtocolGame.registerExtendedOpcode(109, function(protocol, opcode, buffer) -- receive player items added
  local param = buffer:split("@")
  local item_id = tonumber(param[1])
  local item_name = tostring(param[2])

  local item = g_ui.createWidget("Item", panel_items)
  item:setId("item2")
  item:setItemId(item_id)
  item:setTooltip(item_name)

  local btn = g_ui.createWidget("Button", panel_items)
  btn:setId("btn2")
  btn:setSize("15 15")
  btn:setTooltip("Clique aqui para remover o item da lista.")
  btn:setText("-")

  btn.onClick = function() 
    if not g_game.isOnline() then
      return
    end

    g_game.getProtocolGame():sendExtendedOpcode(56, tostring(item_name))
  end

  btn:setMarginTop(6)
  btn:setMarginBottom(4)
  btn:setMarginLeft(5)
  btn:setMarginRight(5)
end)