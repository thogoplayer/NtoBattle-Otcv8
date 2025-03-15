local config = {
	id = 'modTopButton', --Não pode conter espaços
	img = 'button', --ícone do botão [no caso, pega a imagem button.png localizada na pasta do mod]
	options = { --opções que aparecem ao clicar no botão
		--[texto] = comando,
		['Lista de Jutsu'] = '!jutsu',
		['Verificar Saga'] = '!saga',
		['Verificar Elo'] = '!elo',
		['Verificar Task'] = '!task',
		['Withdraw Money'] = '!balance',
		['Olhar Rank'] = '!rank',
		['Trocar de Outfit'] = '',
	}
}

function init()  
   connect(g_game, { onGameStart = reload, onGameEnd = reload})
   TopButton = modules.client_topmenu.addLeftGameToggleButton(config.id, "Comandos", config.img, toggle, true)
   TopButton:setOn(true)
   reload()
end

function toggle()
  local menu = g_ui.createWidget('PopupMenu')
  for _name, _command in pairs(config.options) do
    if _name == "Trocar de Outfit" then
		menu:addOption("Trocar de Outfit", function() g_game.requestOutfit() end)
	else
		menu:addOption(_name, function() g_game.talk(_command) end)
	end
  end
  menu:display()
end

function reload()
	TopButton:setVisible(g_game.isOnline())
end