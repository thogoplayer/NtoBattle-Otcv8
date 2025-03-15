Icons = {}
Icons[1] = { tooltip = tr('You are poisoned'), path = '/game_healthinfo/icons/poisoned.png', id = 'condition_poisoned' }
Icons[2] = { tooltip = tr('You are burning'), path = '/game_healthinfo/icons/burning.png', id = 'condition_burning' }
Icons[4] = { tooltip = tr('You are electrified'), path = '/game_healthinfo/icons/electrified.png', id = 'condition_electrified' }
Icons[8] = { tooltip = tr('You are drunk'), path = '/game_healthinfo/icons/drunk.png', id = 'condition_drunk' }
Icons[16] = { tooltip = tr('You are protected by a magic shield'), path = '/game_healthinfo/icons/magic_shield.png', id = 'condition_magic_shield' }
Icons[32] = { tooltip = tr('You are paralysed'), path = '/game_healthinfo/icons/slowed.png', id = 'condition_slowed' }
Icons[64] = { tooltip = tr('You are hasted'), path = '/game_healthinfo/icons/haste.png', id = 'condition_haste' }
Icons[128] = { tooltip = tr('You may not logout during a fight'), path = '/game_healthinfo/icons/logout_block.png', id = 'condition_logout_block' }
Icons[256] = { tooltip = tr('You are drowing'), path = '/game_healthinfo/icons/drowning.png', id = 'condition_drowning' }
Icons[512] = { tooltip = tr('You are freezing'), path = '/game_healthinfo/icons/freezing.png', id = 'condition_freezing' }
Icons[1024] = { tooltip = tr('You are dazzled'), path = '/game_healthinfo/icons/dazzled.png', id = 'condition_dazzled' }
Icons[2048] = { tooltip = tr('You are cursed'), path = '/game_healthinfo/icons/cursed.png', id = 'condition_cursed' }
Icons[4096] = { tooltip = tr('Você está strengthened'), path = '/game_healthinfo/icons/strengthened.png', id = 'condition_strengthened' }
Icons[8192] = { tooltip = tr('You may not logout or enter a protection zone'), path = '/game_healthinfo/icons/protection_zone_block.png', id = 'condition_protection_zone_block' }
Icons[16384] = { tooltip = tr('You are within a protection zone'), path = '/game_healthinfo/icons/protection_zone.png', id = 'condition_protection_zone' }
Icons[32768] = { tooltip = tr('You are bleeding'), path = '/game_healthinfo/icons/bleeding.png', id = 'condition_bleeding' }
Icons[65536] = { tooltip = tr('You are hungry'), path = '/game_healthinfo/icons/hungry.png', id = 'condition_hungry' }

healthInfoWindow = nil
nameLabel = nil
outfitBox = nil
healthBar = nil
healthLabel = nil
levelLabel = nil
manaBar = nil
manaLabel = nil
experienceBar = nil
experienceLabel = nil
winnerLabel = nil
capLabel = nil
stmBar = nil

function init()
	connect(g_game, { onGameEnd   = offline, onGameStart = refresh })
	connect(LocalPlayer, { onHealthChange = onHealthChange,
						   onManaChange = onManaChange,
						   onStatesChange = onStatesChange,
						   onLevelChange = onLevelChange,
						   onFreeCapacityChange = onFreeCapacityChange,
						   onStaminaChange = onStaminaChange,
						   onSkillChange = onSkillChange })
						   
	
	healthInfoWindow = g_ui.displayUI('health.otui')
	healthInfoWindow:hide()

	
	healthInfoButton = modules.client_topmenu.addLeftGameToggleButton('healthInfoButton', tr('Health Information'), '/images/topbuttons/healthinfo', toggle) 
	
	nameLabel   = healthInfoWindow:getChildById('nameLabel')
	outfitBox   = healthInfoWindow:getChildById('outfitBox')
	levelLabel  = healthInfoWindow:getChildById('levelLabel')
	healthBar   = healthInfoWindow:getChildById('healthBar')
	healthLabel = healthInfoWindow:getChildById('healthLabel')
	capLabel  = healthInfoWindow:getChildById('capLabel')
	experienceBar   = healthInfoWindow:getChildById('experienceBar')
	experienceLabel = healthInfoWindow:getChildById('experienceLabel')
	manaBar   = healthInfoWindow:getChildById('manaBar')
	manaLabel = healthInfoWindow:getChildById('manaLabel')
	winnerLabel = healthInfoWindow:getChildById('winnerLabel')	
	stmBar = healthInfoWindow:getChildById('stmBar')
	
	if g_game.isOnline() then
		onStatesChange(g_game.getLocalPlayer(), g_game.getLocalPlayer():getStates(), 0)
	end
	
	refresh()
end

function terminate()
	disconnect(g_game, { onGameEnd   = offline, onGameStart = refresh })
	disconnect(LocalPlayer, { onHealthChange = onHealthChange,
						      onManaChange = onManaChange,
							  onStatesChange = onStatesChange,
						      onLevelChange = onLevelChange,
							  onFreeCapacityChange = onFreeCapacityChange,
							  onStaminaChange = onStaminaChange,
						      onSkillChange = onSkillChange })
	healthInfoWindow:destroy()
	healthInfoButton:destroy()
end

function toggle()
  if healthInfoWindow:isVisible() then
    healthInfoWindow:hide()
  else
    healthInfoWindow:show()
	refresh()
  end
end

function offline()
	healthInfoWindow:hide()
	healthInfoWindow:recursiveGetChildById('panelCondition'):destroyChildren()
end

function refresh()
	if g_game.isOnline() then
		healthInfoWindow:show()
		local localPlayer = g_game.getLocalPlayer()
		nameLabel:setText(localPlayer:getName())
		--outfitBox:setOutfit(localPlayer:getOutfit())
		onHealthChange(localPlayer, localPlayer:getHealth(), localPlayer:getMaxHealth())
		onManaChange(localPlayer, localPlayer:getMana(), localPlayer:getMaxMana())
		onLevelChange(localPlayer, localPlayer:getLevel(), localPlayer:getLevelPercent())
		onFreeCapacityChange(localPlayer, localPlayer:getFreeCapacity())	
		onStaminaChange(localPlayer, localPlayer:getStamina())		
		-- onSkillChange(localPlayer, 2, localPlayer:getSkillLevel(2), localPlayer:getSkillLevelPercent(2),true)
		-- onSkillChange(localPlayer, 6, localPlayer:getSkillLevel(6), localPlayer:getSkillLevelPercent(6), true)
	end
end

function setOutfitBox(outfit)
	--outfitBox:setOutfit(outfit)
end

function onHealthChange(localPlayer, health, maxHealth)
  healthBar:setValue(health, 0, maxHealth)
  healthLabel:setText(math.floor(health / maxHealth * 100).."%")
end

function onManaChange(localPlayer, mana, maxMana)
	manaBar:setValue(mana, 0, maxMana)
	manaLabel:setText(math.floor(mana / maxMana * 100).."%")
end

function onLevelChange(localPlayer, value, percent)
  levelLabel:setText('Lv '..localPlayer:getLevel())
  levelLabel:setColor(White)
  levelLabel:setHeight(8, 10)
  experienceLabel:setText(percent.. "%")
  experienceBar:setPercent(percent)
end

function onFreeCapacityChange(localPlayer, freeCapacity)
  capLabel:setText(freeCapacity)
end

-- function onSkillChange(localPlayer, id, level, percent, hur)
	-- if id == 2 then
		-- winnerLabel:setText(level)
		-- winnerLabel:setTooltip('Vitorias: '..level)
	-- end
	-- if id == 6 then
		-- fishBar:setPercent(percent)
		-- fishBar:setTooltip(tr("Fishing: "..level))
		-- fishLabel:setText(percent.."%")
	-- end
-- end

function onStaminaChange(localPlayer, stamina)
  local hours = math.floor(stamina / 60)
  local minutes = stamina % 60
  if minutes < 10 then
    minutes = '0' .. minutes
  end
  local percent = math.floor(100 * stamina / (42 * 60))
  stmBar:setPercent(percent)
  stmBar:setTooltip("stamina "..hours .. ":" .. minutes)
end

function onStatesChange(localPlayer, now, old)
  if now == old then return end
  local bitsChanged = bit32.bxor(now, old)
  for i = 1, 32 do
    local pow = math.pow(2, i-1)
    if pow > bitsChanged then break end
    local bitChanged = bit32.band(bitsChanged, pow)
    if bitChanged ~= 0 then
      toggleIcon(bitChanged)
    end
  end
end

function toggleIcon(bitChanged)
  local content = healthInfoWindow:recursiveGetChildById('panelCondition')

  local icon = content:getChildById(Icons[bitChanged].id)
  if icon then
    icon:destroy()
  else
    icon = g_ui.createWidget('ConditionWidget', content)
    icon:setId(Icons[bitChanged].id)
    icon:setImageSource(Icons[bitChanged].path)
    icon:setTooltip(Icons[bitChanged].tooltip)
  end
end

-- Thalles Vitor - Setar Personagem
ProtocolGame.registerExtendedOpcode(77, function(protocol, opcode, buffer)
	local param = buffer:split("@")
	local vocation_id = tonumber(param[1])
	
	outfitBox:setImageSource("img/vocations/" .. vocation_id .. ".png")
end)
