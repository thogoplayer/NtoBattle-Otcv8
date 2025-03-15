UI.Separator()
local showhp = macro(20000, "Monstro Hp %", function() end)
onCreatureHealthPercentChange(function(creature, healthPercent)
    if showhp:isOff() then  return end
    if creature:isMonster() or creature:isPlayer() and creature:getPosition() and pos() then
        if getDistanceBetween(pos(), creature:getPosition()) <= 5 then
            creature:setText(healthPercent .. "%")
        else
            creature:clearText()
  

      end
    end
end)

UI.Separator ()local doAutoLootLook = macro(5000, "Auto Loot Look",  function() end)
onTextMessage(function(mode, text)
    if mode == 20 and text:find("You see") and doAutoLootLook:isOn() then
        local regex = [[You see (?:an|a)([a-z A-Z]*).]]
        local data = regexMatch(text, regex)[1]
        if data and data[2] then
            say('!autoloot add, ' ..data[2]:trim())
        end
    end
end)UI.Separator () local moneyIds = {3031, 3035} -- gold coin, platinium coin
macro(1000, "Money", function()
  local containers = g_game.getContainers()
  for index, container in pairs(containers) do
    if not container.lootContainer then -- ignore monster containers
      for i, item in ipairs(container:getItems()) do
        if item:getCount() == 100 then
          for m, moneyId in ipairs(moneyIds) do
            if item:getId() == moneyId then
              return g_game.use(item)            
            end
          end
        end
      end
    end
  end
end)

UI.Separator()

macro(60000, "Msg trade", function()
  local Trade = getChannelId("advertising")
  if not Trade then
    Trade = getChannelId("Trade")
  end
  if Trade and storage.autoTradeMessage:len() > 0 then    
    sayChannel(Trade, storage.autoTradeMessage)
  end
end)
UI.TextEdit(storage.autoTradeMessage or "hi ", function(widget, text)    
  storage.autoTradeMessage = text
end)

UI.Separator()
macro(60000, "Msg Help", function()
  local Help = getChannelId("advertising")
  if not Help then
    Help = getChannelId("Help")
  end
  if Help and storage.autoHelpMessage:len() > 0 then    
    sayChannel(Help, storage.autoHelpMessage)
  end
end)
UI.TextEdit(storage.autoHelpMessage or "hi", function(widget, text)    
  storage.autoHelpMessage = text
end)

UI.Separator()