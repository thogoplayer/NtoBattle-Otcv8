-- tools tab
setDefaultTab("Tools")

-- allows to test/edit bot lua scripts ingame, you can have multiple scripts like this, just change storage.ingame_lua
UI.Button("Hotkeys 2", function(newText)
  UI.MultilineEditorWindow(storage.ingame_hotkeys2 or "", {title="Hotkeys editor", description="You can add your custom hotkeys/singlehotkeys here"}, function(text)
    storage.ingame_hotkeys2 = text
    reload()
  end)
end)

UI.Separator()

for _, scripts in pairs({storage.ingame_hotkeys2}) do
  if type(scripts) == "string" and scripts:len() > 3 then
    local status, result = pcall(function()
      assert(load(scripts, "ingame_editor"))()
    end)
    if not status then 
      error("Ingame edior error:\n" .. result)
    end
  end
end

UI.Separator() 

 UI.Separator() followName = "autofollow"
if not storage[followName] then storage[followName] = { player = 'name'} end
local toFollowPos = {}

lblInfo= UI.Label("-- [[ FOLLOW ]] --")
lblInfo:setColor("green")

addSeparator()

followTE = UI.TextEdit(storage[followName].player or "name", function(widget, newText)
    storage[followName].player = newText
end)

local followChange = macro(1000, "Follow",  function()
local followw= storage[followName].player 
    if g_game.isFollowing() then
        return
    end
    for _, followcreature in ipairs(g_map.getSpectators(pos(), false)) do
        if (followcreature:getName() == followw and getDistanceBetween(pos(), followcreature:getPosition()) <= 8) then
            g_game.follow(followcreature)
        end
    end
end) 

local followMacro = macro(20, "Follow Attack", function()
    local target = getCreatureByName(storage[followName].player)
    if target then
        local tpos = target:getPosition()
        toFollowPos[tpos.z] = tpos
    end
    if player:isWalking() then
        return
    end
    local p = toFollowPos[posz()]
    if not p then
        return
    end
    if autoWalk(p, 20, { ignoreNonPathable = true, precision = 1 }) then
        delay(100)
    end
end)
UI.Separator()
onPlayerPositionChange(function(newPos, oldPos)
  if followChange:isOff() then return end
  if (g_game.isFollowing()) then
    tfollow = g_game.getFollowingCreature()

    if tfollow then
      if tfollow:getName() ~= storage[followName].player then
        followTE:setText(tfollow:getName())
        storage[followName].player = tfollow:getName()
      end
    end
  end
end)

onCreaturePositionChange(function(creature, newPos, oldPos)
    if creature:getName() == storage[followName].player and newPos then
        toFollowPos[newPos.z] = newPos
    end
end) 






 




 

lblInfo= UI.Label("-- [[ ANTI - PUSH ]] --")
lblInfo:setColor("green")

addSeparator() local dropItems = { 3031, 3035 }
local maxStackedItems = 10
local dropDelay = 600

gpAntiPushDrop = macro(dropDelay , "Anti-Push", "shift+d", function ()
  antiPush()
end)

onPlayerPositionChange(function()
    antiPush()
end)

function antiPush()
  if gpAntiPushDrop:isOff() then
    return
  end

  local tile = g_map.getTile(pos())
  if tile and tile:getThingCount() < maxStackedItems then
    local thing = tile:getTopThing()
    if thing and not thing:isNotMoveable() then
      for i, item in pairs(dropItems) do
        if item ~= thing:getId() then
            local dropItem = findItem(item)
            if dropItem then
              g_game.move(dropItem, pos(), 2)
            end
        end
      end
    end
  end
end UI.Separator() 

lblInfo= UI.Label("-- [[ STOP CAVE/TARGET ]] --")
lblInfo:setColor("green")
addSeparator()singlehotkey("shift+space", "Stop/Cave", function()
if CaveBot.isOn() or TargetBot.isOn() then
CaveBot.setOff()
TargetBot.setOff()
elseif CaveBot.isOff() or TargetBot.isOff() then
CaveBot.setOn()
TargetBot.setOn()
end
end) UI.Separator()



  local ui = setupUI([[
Panel

  height: 25

  Label
    id: editCustom2
    color: red
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 25
    !text: tr('                         @NtoBattle')


  ]], parent)


ui.editCustom2.onClick = function(widget)
reload()
end
