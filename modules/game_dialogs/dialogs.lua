-- Caixa de Dialogos --
local dialogs = g_ui.displayUI("dialogs")
local outfit = dialogs:getChildById("npc_outfit")
local name = dialogs:getChildById("npc_name")
local text = dialogs:getChildById("npc_dialogText")
local panel_btns = dialogs:getChildById("buttons_list")
local buttonsList = {}

function init()
  connect(g_game, { 
    onGameStart = naoexibir,
    onGameEnd = naoexibir,
  })

  dialogs:hide()
 --dialogs:getChildById("npc_outfit"):setOutfit{type = 522}
end

function terminate()
  disconnect(g_game, { 
    onGameStart = naoexibir,
    onGameEnd = naoexibir,
  })

  dialogs:hide()
end

function exibir()
  dialogs:show()
end

function naoexibir()
  dialogs:hide()
end

ProtocolGame.registerExtendedOpcode(225, function(protocol, opcode, buffer) -- receive npc dialog
	local param = buffer:split("@")
	local npc_name = tostring(param[1])
	local npc_outfit = tonumber(param[2])
	local npc_text = tostring(param[3])
	
	panel_btns:destroyChildren()
	dialogs:show()
	g_effects.fadeIn(dialogs, 1000)
	
	outfit:setOutfit({type = npc_outfit})
	name:setText(npc_name)
	text:setText(npc_text)
end)

ProtocolGame.registerExtendedOpcode(226, function(protocol, opcode, buffer) -- receive npc dialog
	local param = buffer:split("@")
	
	if param[1] == "fechar" then
		outfit:setOutfit({type = 1})
		name:setText("")
		text:setText("")

		dialogs:hide()
		g_effects.fadeOut(dialogs, 1000)
	end
end)

ProtocolGame.registerExtendedOpcode(227, function(protocol, opcode, buffer) -- receive npc dialog buttons
	local param = buffer:split("@")
	local buttons = tostring(param[1])
	
	local button = g_ui.createWidget("DialogButton", panel_btns)
	button:setMarginTop(0)
	button:setMarginLeft(0)
	button:setSize("80 20")
	button:setText(buttons)
	button.onClick = function() 
		if string.lower(buttons) == "fechar" then
			dialogs:hide()
		else
			--g_game.talkChannel(51, -1, buttons)
			 g_game.talkPrivate(11, "NPCs", buttons)
		end
	end
end)