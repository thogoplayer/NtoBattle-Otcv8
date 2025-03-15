TargetBot.Creature.edit = function(config, callback) -- callback = function(newConfig)
  config = config or {}

  local editor = UI.createWindow('TargetBotCreatureEditorWindow')
  local values = {} -- (key, function returning value of key)

  editor.name:setText(config.name or "")
  table.insert(values, {"name", function() return editor.name:getText() end})

  local addScrollBar = function(id, title, min, max, defaultValue)
    local widget = UI.createWidget('TargetBotCreatureEditorScrollBar', editor.left)
    widget.scroll.onValueChange = function(scroll, value)
      widget.text:setText(title .. ": " .. value)
    end
    widget.scroll:setRange(min, max)
    if max-min > 1000 then
      widget.scroll:setStep(100)
    elseif max-min > 100 then
      widget.scroll:setStep(10)
    end
    widget.scroll:setValue(config[id] or defaultValue)
    widget.scroll.onValueChange(widget.scroll, widget.scroll:getValue())
    table.insert(values, {id, function() return widget.scroll:getValue() end})
  end

  local addTextEdit = function(id, title, defaultValue)
    local widget = UI.createWidget('TargetBotCreatureEditorTextEdit', editor.right)
    widget.text:setText(title)
    widget.textEdit:setText(config[id] or defaultValue or "")
    table.insert(values, {id, function() return widget.textEdit:getText() end})
  end

  local addCheckBox = function(id, title, defaultValue)
    local widget = UI.createWidget('TargetBotCreatureEditorCheckBox', editor.right)
    widget.onClick = function()
      widget:setOn(not widget:isOn())
    end
    widget:setText(title)
    if config[id] == nil then
      widget:setOn(defaultValue)
    else
      widget:setOn(config[id])
    end
    table.insert(values, {id, function() return widget:isOn() end})
  end

  local addItem = function(id, title, defaultItem)
    local widget = UI.createWidget('TargetBotCreatureEditorItem', editor.right)
    widget.text:setText(title)
    widget.item:setItemId(config[id] or defaultItem)
    table.insert(values, {id, function() return widget.item:getItemId() end})
  end

  editor.cancel.onClick = function()
    editor:destroy()
  end
  editor.onEscape = editor.cancel.onClick

  editor.ok.onClick = function()
    local newConfig = {}
    for _, value in ipairs(values) do
      newConfig[value[1]] = value[2]()
    end
    if newConfig.name:len() < 1 then return end
    newConfig.regex = "^" .. newConfig.name:trim():lower():gsub("%*", ".*"):gsub("%?", ".?") .. "$"

    editor:destroy()
    callback(newConfig)
  end

  -- values
  addScrollBar("priority", "Prioridade", 0, 10, 1)
  addScrollBar("danger", "Perigo", 0, 10, 1)
  addScrollBar("maxDistance", "Distancia maxima", 1, 10, 10)
  addScrollBar("keepDistanceRange", "Manter Distancia", 1, 5, 1)
  addScrollBar("lureCount", "Lure", 0, 5, 1)

 

  addCheckBox("chase", "Ataque Follow", true)
  addCheckBox("keepDistance", "Manter Distancia", false)
  addCheckBox("lure", "Lure", false)
  addCheckBox("lureCavebot", "Lure usando cavebot", false)
  addCheckBox("avoidAttacks", "Atacar em diagonal", false)


end
