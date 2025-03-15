local OPCODE = 53
local window, creatureBarHP, creatureHP, creatureName = nil
local focusedBoss = 0
local focusedMob = 0
local outfitBox = nil

function init()
	connect(g_game, {
		onGameStart = create,
		onGameEnd = destroy,
		onAttackingCreatureChange = onAttackingCreatureChange
	})
	connect(Creature, {
		onHealthPercentChange = onHealthPercentChange,
		onSpecialPercentChange = onSpecialPercentChange
	})

	if g_game.isOnline() then
		create()
	end
end

function terminate()
	disconnect(g_game, {
		onGameStart = create,
		onGameEnd = destroy,
		onAttackingCreatureChange = onAttackingCreatureChange
	})
	disconnect(Creature, {
		onHealthPercentChange = onHealthPercentChange,
		onSpecialPercentChange = onSpecialPercentChange
	})
	destroy()
end

function create()
	if window then
		return
	end

	window = g_ui.loadUI("bossbar", modules.game_interface.getMapPanel())

	window:hide()

	creatureBarHP = window:recursiveGetChildById("creatureBarHP")
	creatureName = window:recursiveGetChildById("creatureName")
	creatureHP = window:recursiveGetChildById("creatureHP")
	creatureOutfit = window:recursiveGetChildById('outfitBox')
	creatureSpecial = window:recursiveGetChildById("special")
end

function destroy()
	if window then
		window:destroy()

		window = nil
		creatureBarHP = nil
		creatureHP = nil
		creatureOutfit = nil
		creatureName = nil
		creatureSpecial = nil
		focusedBoss = 0
		focusedMob = 0
	end
end

function onExtendedOpcode(protocol, code, buffer)
	if not g_game.isOnline() then
		return
	end

	local json_status, json_data = pcall(function ()
		return json.decode(buffer)
	end)

	if not json_status then
		g_logger.error("[Boss Bar] JSON error: " .. data)

		return false
	end

	if json_data.action == "show" then
		show(json_data.data)
	elseif json_data.action == "hide" then
		hide()
	end
end

function show(data)
	focusedBoss = data.cid

	creatureName:setText(data.name)
	-- creatureBarHP:setPercent(data.health)
	creatureHP:setText(data.health .. "%")
	creatureSpecial:setPercent(data.health)
	creatureOutfit:setOutfit(data.outfit)
	window:show()
end

function hide()
	focusedBoss = 0
	focusedMob = 0

	window:hide()
end

bossBarEnabled = true

function setEnabled(value)
	bossBarEnabled = value
end

function onAttackingCreatureChange(creature, oldCreature)
	if bossBarEnabled then
		if focusedBoss ~= 0 then
			return
		end

		if creature then
			creatureName:setText(creature:getName())
			creatureHP:setText(creature:getHealthPercent() .. "%")
			creatureSpecial:setPercent(creature:getHealthPercent())
			creatureOutfit:setOutfit(creature:getOutfit())
			--  creatureBarHP:setPercent(creature:getHealthPercent())

			focusedMob = creature:getId()

			window:show()
		else
			hide()
		end
	else
		hide()
	end
end

function onHealthPercentChange(creature, health)
	if bossBarEnabled then
		if focusedBoss == creature:getId() or focusedMob == creature:getId() then
			-- creatureBarHP:setPercent(health)
			creatureHP:setText(health .. "%")
			creatureSpecial:setPercent(health)
		end
	else
		hide()
	end
end

function onSpecialPercentChange(creature, special)
	if special > 0 then
		if not creatureSpecial:isVisible() then
			creatureSpecial:setVisible(true)
		end

		creatureSpecial:setPercent(special)
	else
		creatureSpecial:setVisible(false)
	end
end

