local spelllist = {
  ['Death Strike'] =             {id = 87,  words = 'exori mort',            exhaustion = 2000,  premium = true,  type = 'Instant', icon = 'deathstrike',            mana = 20,     level = 16, soul = 0, group = {[1] = 2000},               vocations = {1, 5}},
  ['Flame Strike'] =             {id = 89,  words = 'exori flam',            exhaustion = 2000,  premium = true,  type = 'Instant', icon = 'flamestrike',            mana = 20,     level = 14, soul = 0, group = {[1] = 2000},               vocations = {1, 2, 5, 6}},
  ['Strong Flame Strike'] =      {id = 150, words = 'exori gran flam',       exhaustion = 8000,  premium = true,  type = 'Instant', icon = 'strongflamestrike',      mana = 60,     level = 70, soul = 0, group = {[1] = 2000, [4] = 8000},   vocations = {1, 5}},
  ['Ultimate Flame Strike'] =    {id = 154, words = 'exori max flam',        exhaustion = 30000, premium = true,  type = 'Instant', icon = 'ultimateflamestrike',    mana = 100,    level = 90, soul = 0, group = {[1] = 4000},               vocations = {1, 5}},
  ['Energy Beam'] =              {id = 22,  words = 'exevo vis lux',         exhaustion = 4000,  premium = false, type = 'Instant', icon = 'energybeam',             mana = 40,     level = 23, soul = 0, group = {[1] = 2000},               vocations = {1, 5}},
  ['Great Energy Beam'] =        {id = 23,  words = 'exevo gran vis lux',    exhaustion = 6000,  premium = false, type = 'Instant', icon = 'greatenergybeam',        mana = 110,    level = 29, soul = 0, group = {[1] = 2000},               vocations = {1, 5}},
  ['Groundshaker'] =             {id = 106, words = 'exori mas',             exhaustion = 8000,  premium = true,  type = 'Instant', icon = 'groundshaker',           mana = 160,    level = 33, soul = 0, group = {[1] = 2000},               vocations = {4, 8}},
  ['Recovery'] =                 {id = 159, words = 'utura',                 exhaustion = 60000, premium = true,  type = 'Instant', icon = 'recovery',               mana = 75,     level = 50, soul = 0, group = {[2] = 1000},               vocations = {4, 8, 3, 7}},
  ['Intense Recovery'] =         {id = 160, words = 'utura gran',            exhaustion = 60000, premium = true,  type = 'Instant', icon = 'intenserecovery',        mana = 165,    level = 100,soul = 0, group = {[2] = 1000},               vocations = {4, 8, 3, 7}},
  ['Salvation'] =                {id = 36,  words = 'exura gran san',        exhaustion = 1000,  premium = true,  type = 'Instant', icon = 'salvation',              mana = 210,    level = 60, soul = 0, group = {[2] = 1000},               vocations = {3, 7}},
  ['Intense Healing'] =          {id = 2,   words = 'exura gran',            exhaustion = 1000,  premium = false, type = 'Instant', icon = 'intensehealing',         mana = 70,     level = 20, soul = 0, group = {[2] = 1000},               vocations = {1, 2, 3, 5, 6, 7}},
  ['Heal Friend'] =              {id = 84,  words = 'exura sio',             exhaustion = 1000,  premium = true,  type = 'Instant', icon = 'healfriend',             mana = 140,    level = 18, soul = 0, group = {[2] = 1000},               vocations = {2, 6}},
  ['Ultimate Healing'] =         {id = 3,   words = 'exura vita',            exhaustion = 1000,  premium = false, type = 'Instant', icon = 'ultimatehealing',        mana = 160,    level = 30, soul = 0, group = {[2] = 1000},               vocations = {1, 2, 5, 6}},
  ['Mass Healing'] =             {id = 82,  words = 'exura gran mas res',    exhaustion = 2000,  premium = true,  type = 'Instant', icon = 'masshealing',            mana = 150,    level = 36, soul = 0, group = {[2] = 1000},               vocations = {2, 6}},
  ['Divine Healing'] =           {id = 125, words = 'exura san',             exhaustion = 1000,  premium = false, type = 'Instant', icon = 'divinehealing',          mana = 160,    level = 35, soul = 0, group = {[2] = 1000},               vocations = {3, 7}},
  ['Light'] =                    {id = 10,  words = 'utevo lux',             exhaustion = 2000,  premium = false, type = 'Instant', icon = 'light',                  mana = 20,     level = 8,  soul = 0, group = {[3] = 2000},               vocations = {1, 2, 3, 4, 5, 6, 7, 8}},
  ['Magic Rope'] =               {id = 76,  words = 'exani tera',            exhaustion = 2000,  premium = true,  type = 'Instant', icon = 'magicrope',              mana = 20,     level = 9,  soul = 0, group = {[3] = 2000},               vocations = {1, 2, 3, 4, 5, 6, 7, 8}},
  ['Levitate'] =                 {id = 81,  words = 'exani hur',             exhaustion = 2000,  premium = true,  type = 'Instant', icon = 'levitate',               mana = 50,     level = 12, soul = 0, group = {[3] = 2000},               vocations = {1, 2, 3, 4, 5, 6, 7, 8}},
  ['Great Light'] =              {id = 11,  words = 'utevo gran lux',        exhaustion = 2000,  premium = false, type = 'Instant', icon = 'greatlight',             mana = 60,     level = 13, soul = 0, group = {[3] = 2000},               vocations = {1, 2, 3, 4, 5, 6, 7, 8}},
  ['Magic Shield'] =             {id = 44,  words = 'utamo vita',            exhaustion = 2000,  premium = false, type = 'Instant', icon = 'magicshield',            mana = 50,     level = 14, soul = 0, group = {[3] = 2000},               vocations = {1, 2, 5, 6}},
  ['Haste'] =                    {id = 6,   words = 'utani hur',             exhaustion = 2000,  premium = true,  type = 'Instant', icon = 'haste',                  mana = 60,     level = 14, soul = 0, group = {[3] = 2000},               vocations = {1, 2, 3, 4, 5, 6, 7, 8}},
}
local spells = {}
local lado = 'horizontal'
local sbw -- window widget
local sbb -- button ./\ widget
local spellBarWindow -- UIWindow
local exhsaustionTotal = 1100
local hideLevel = false -- os que nao tem level, vai mostrar? true = nao, false = sim
function init()
  sbb = modules.client_topmenu.addRightGameToggleButton('sbb', 'Spell Bar' , 'SpellBar.png', toggle)
  sbw = g_ui.displayUI('SpellBar')
  sbw:move(50,50)
  g_mouse.bindPress(sbw, function() createMenu() end, MouseRightButton)
  sbw:hide()
  connect(g_game, 'onTalk', mensagemEnviada)
  connect(g_game, { onGameEnd = function() sbw:hide() sbb:setOn(false) end })
  connect(LocalPlayer, {
    onLevelChange = onLevelChange
  })
  for inst,values in pairs(spelllist) do
    if values.type == 'Instant' then -- depois vou fazer mais tipos..
	  if g_game.getProtocolVersion() >= 950 then -- Vocation is only send in newer clients
        if table.find(values.vocations, g_game.getLocalPlayer():getVocation()) then
          local inside = {instantName = inst, words = values.words, lvl = values.level, mana = values.mana, prem = values.premium, groups = values.group,icon = values.icon, vocations = values.vocations,exhaustion = values.exhaustion}
          table.insert(spells,inside)
        end
      else
        local inside = {instantName = inst, words = values.words, lvl = values.level, mana = values.mana, prem = values.premium, groups = values.group,icon = values.icon, vocations = values.vocations,exhaustion = values.exhaustion}
        table.insert(spells,inside)
      end
    end
  end
  table.sort(spells, function(a, b) return (a.lvl < b.lvl) end)
end

function onLevelChange(localPlayer, value, percent)
  getSpells(spells)
end
function mensagemEnviada(name, level, mode, text, channelId, pos)
if not g_game.isOnline() then return end
if g_game.getLocalPlayer():getName() ~= name then return end
  for i = 1,#spells do
   if spells[i].words:lower() == text:lower() then 
     startDownDelay(i)
     break
   end
  end
end

function terminate()
  sbw:destroy()
  sbb:destroy()
  disconnect(g_game, { onGameEnd = function() sbw:hide() sbb:setOn(false) end })
  disconnect(g_game, 'onTalk', mensagemEnviada)
  disconnect(LocalPlayer, {
    onLevelChange = onLevelChange
  })
end

function toggle()
  if sbb:isOn() then
    sbw:hide()
    sbb:setOn(false)
  else
    sbw:show()
    getSpells(spells)
    sbb:setOn(true)
    level = g_game.getLocalPlayer():getLevel()
  end
end

function createMenu()
  local menu = g_ui.createWidget('PopupMenu')
  if lado == 'horizontal' then
    menu:addOption('Set Vertical', function() lado = 'vertical' getSpells(spells) end)
  else
    menu:addOption('Set Horizontal',function() lado = 'horizontal' getSpells(spells) end)
  end
  if hideLevel == false then
    menu:addOption('No Level Hide',function() hideLevel = true getSpells(spells) end)
  else
    menu:addOption('No Level Show',function() hideLevel = false getSpells(spells) end)
  end
  menu:display()
end

function destruirSpells()
  for i = 1,100 do
    if sbw:recursiveGetChildById('spell'..i) == nil then break end
    sbw:recursiveGetChildById('spell'..i):destroy()
    sbw:recursiveGetChildById('progress'..i):destroy()
  end
end

function getSpells(tabela)
  destruirSpells()
  spellBarWindow = sbw:recursiveGetChildById('mainWindow')
  local player = g_game.getLocalPlayer()
  local valor = #tabela
  local width = 38
  local height = 38
  if not player then return end
  for i = 1,#tabela do
    if (tabela[i].lvl > player:getLevel()) and hideLevel == true then
      valor = i - 1
	  break
	end
    if i == #tabela then valor = i end
    icon = g_ui.createWidget('SpellButton',spellBarWindow)
	progress = g_ui.createWidget('SpellProgressSpell',spellBarWindow)
    --icon:
    icon:setId('spell'..i)
	local spicon = Spells.getClientId(tabela[i].instantName)
    icon:setImageSource('/images/game/spells/defaultspells')
    icon:setImageClip((((spicon -1)%12)*32) .. ' ' .. ((math.ceil(spicon/12)-1)*32) .. ' 32 32')
    icon:setVisible(true) 
    icon.words = tabela[i].words
    icon.instantName = tabela[i].instantName
    icon.lvl = tabela[i].lvl
    icon.mana = tabela[i].mana
    icon.exhaustion = tabela[i].exhaustion
    icon.exhaustionNeeded = 0
    icon:setTooltip(tabela[i].words)
    if lado == 'horizontal' then
        icon:setMarginTop(3)
        height = 38
        width = (i) * 32 + 2*(i)
        icon:setMarginLeft((i) * 32 + 2*(i) - 32)
    else
        icon:setMarginLeft(3)
        icon:setMarginTop((i) * 32 + 2*(i) - 32)
        width = 38
        height = (i) * 32 + 2*(i)
    end
    --progress:
    progress:setId('progress'..i)	
    progress:setVisible(true) 
    progress:setPercent(100)
    progress:setMarginLeft(icon:getMarginLeft())
    progress:setMarginTop(icon:getMarginTop())
    if player:getLevel() < icon.lvl then progress:setText('L'..icon.lvl) progress:setColor('red') progress:setPercent(0) end
    if progress:getPercent() == 100 then progress:setText('OK') elseif icon.lvl < player:getLevel() then progress:setText(progress:getPercent()) end
    progress:setPhantom(true)
    icon.onClick = function() useSpell(i) end
  end
  sbw:setHeight(height)
  sbw:setWidth(width)  
  spellBarWindow:setSize(sbw:getSize())
end

function useSpell(i)
  local spell = sbw:recursiveGetChildById('spell'..i)
  if not spell then return end
  local progress = sbw:recursiveGetChildById('progress'..i)
  local player = g_game.getLocalPlayer()
  if not player then return end
  if progress:getPercent() < 100 then return modules.game_textmessage.displayFailureMessage('Wait your delay!') end
  g_game.talk(spell.words)
end

function startDownDelay(i) -- aqui vai ficar on onTalk, pra descer só realmente quando a spell sair
  local spell = sbw:recursiveGetChildById('spell'..i)
  if not spell then return end
  local progress = sbw:recursiveGetChildById('progress'..i)
  progress:setPercent(0)
  progress:setText('0%')
  progress:setColor('red')
  spell.exhaustionNeeded = 0
  scheduleEvent(function() spellTimeleft(i) end,100) 
end

function spellTimeleft(i)
  local spell = sbw:recursiveGetChildById('spell'..i)
  if not spell then return end
  local progress = sbw:recursiveGetChildById('progress'..i)
  spell.exhaustionNeeded = spell.exhaustionNeeded + 100
  if spell.exhaustionNeeded < spell.exhaustion then
    progress:setPercent(math.ceil(((spell.exhaustionNeeded) * 100)/spell.exhaustion))
    progress:setText(progress:getPercent())
    progress:setColor('red')
  else
    progress:setPercent(100)
    progress:setText('OK')
    progress:setColor('green')
    spell.exhaustionNeeded = 0    
    return true
  end
  scheduleEvent(function() spellTimeleft(i) end,100) 
end