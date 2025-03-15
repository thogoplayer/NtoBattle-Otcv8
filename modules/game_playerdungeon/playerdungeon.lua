-- Criado por Thalles Vitor --
-- Module de Dungeon --
local dungeon = g_ui.displayUI("playerdungeon")
local panel_level = dungeon:getChildById("levels_recommended")
local panel_difficulty = dungeon:getChildById("dificultys_recommended")
local panel_missions = dungeon:getChildById("list_missions")
local panel_items = dungeon:getChildById("necessary_items_container")
local panel_team = dungeon:getChildById("team_box")
local jogar = dungeon:getChildById("play_btn")
local dungeonButton = nil
local window_invite = nil
local window_text = nil
local window_button = nil
local window_button2 = nil

local window_acceptinvite = nil

-- Informations
local dungeonOPCODE_DESTROYINFO = 87 -- opcode para destruir as informacoes anteriores antes de abrir
local dungeonOPCODE_LEVELS = 88 -- opcode da janela que vai receber as informacoes: leveis
local dungeonOPCODE_DIFICULTYS = 89 -- opcode da janela que vai receber as informacoes: dificuldade
local dungeonOPCODE_MISSIONS = 90 -- opcode da janela que vai receber as informacoes: missoes do jogo
local dungeonOPCODE_ITEMS = 91 -- opcode da janela que vai recdeber as informacoes: items necessarios para entrar na DG
local dungeonOPCODE_INVITE = 92 -- opcode da janela que vai receber as informacoes: convite do player
local dungeonOPCODE_PLAYERS_PARTY = 93 -- opcode da janela que vai receber as informacoes: players da party
local dungeonOPCODE_closeWIndow = 96 -- opcode para fechar a janela quando entrar na dungeon

lista = {} -- lista de labels do nivel de dificuldade
lista2 = {} -- lista de labels do nivel
lista3 = {} -- lista das imagens
lista4 = {} -- lista das imagens (caminho e nome)
selectedCategory = "Gennin/Chunnin" -- Mostrar a categoria selecionada
selectedNumeration = 1 -- Numero da DG Selecionado

function init()
    connect(g_game, {
        onGameStart = naoexibir,
        onGameEnd = naoexibir,
    })

    dungeonButton = modules.client_topmenu.addLeftGameToggleButton('DungeonButton', tr('Dungeon'), 'dungeon.png', exibir)
    dungeonButton:setWidth(34)
    dungeonButton:setOn(false)
    dungeon:hide()

    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_closeWIndow, function(protocol, opcode, buffer) onHideDungeonClose(buffer) end)
    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_DESTROYINFO, function(protocol, opcode, buffer) onDestroyInfoDungeon(buffer) end)
    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_LEVELS, function(protocol, opcode, buffer) onReceiveDungeonLevel(buffer) end)
    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_DIFICULTYS, function(protocol, opcode, buffer) onReceiveDungeonDifficulty(buffer) end)
    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_MISSIONS, function(protocol, opcode, buffer) onReceiveDungeonMissions(buffer) end)
    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_ITEMS, function(protocol, opcode, buffer) onReceiveDungeonItems(buffer) end)
    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_INVITE, function(protocol, opcode, buffer) onReceiveDungeonInvite(buffer) end)
    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_PLAYERS_PARTY, function(protocol, opcode, buffer) onReceiveDungeonParty(buffer) end)
end

function terminate()
    disconnect(g_game, {
        onGameStart = naoexibir,
        onGameEnd = naoexibir,
    })

    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_closeWIndow)
    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_DESTROYINFO)
    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_LEVELS)
    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_DIFICULTYS)
    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_MISSIONS)
    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_ITEMS)
    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_INVITE)
    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_PLAYERS_PARTY)

    if window_invite then 
        window_invite:hide()
        window_text:hide()

        window_invite = nil
    end

    dungeonButton:setOn(false)
    dungeon:hide()
end

function exibir()
    if window_invite then 
        window_invite:hide()
        window_text:hide()

        window_invite = nil
    end

    if dungeonButton:isOn() then
        dungeonButton:setOn(false)
        dungeon:hide()
    else
        dungeonButton:setOn(true)
        dungeon:show()

        if g_game.isOnline() then
            g_game.getProtocolGame():sendExtendedOpcode(44, selectedCategory.."@")
        end
    end
end

function naoexibir()
    if window_invite then 
        window_invite:hide()
        window_text:hide()

        window_invite = nil
    end
    
    dungeonButton:setOn(false)
    dungeon:hide()
end

function onDestroyInfoDungeon(buffer)
    local param = buffer:split("@")
    local type = tostring(param[1])
    
    if type == "destroyInfo_levels" then
        panel_level:destroyChildren()
    end

    if type == "destroyInfo_difficulty" then
        panel_difficulty:destroyChildren()
    end

    if type == "destroyInfo_missions" then
        panel_missions:destroyChildren()
    end

    if type == "destroyInfo_items" then
        panel_items:destroyChildren()
    end

    if type == "destroyInfo_team" then
        panel_team:destroyChildren()
    end
end

function onReceiveDungeonLevel(buffer)
    local param = buffer:split("@")
    local levels = tostring(param[1])

    local label = g_ui.createWidget("Label", panel_level)
    label:setColor("gray")
    label:setText(levels)
    table.insert(lista2, label)

    if levels == "80-170" then
        label:setColor("white")
    end
end

function onHideDungeonClose(buffer)
    local param = buffer:split("@")
    dungeon:hide()
end

function onReceiveDungeonDifficulty(buffer)
    local param = buffer:split("@")
    local difficultys = tostring(param[1])
    local numeration = tonumber(param[2])

    local label = g_ui.createWidget("LevelLabel", panel_difficulty)
    label:setText(difficultys)

    table.insert(lista, label)

    if difficultys == "Gennin/Chunnin" then
        label:setColor("white")
    end

    label.onClick = function()
        for i = 1, #lista do
            if lista[i] ~= label then
                lista[i]:setColor("gray")
            end

            if lista[i] ~= numeration then
                lista2[i]:setColor("gray")
            end

            g_game.getProtocolGame():sendExtendedOpcode(45, label:getText().."@") -- requisicao para trocar a categoria
            label:setColor("black")
            lista2[numeration]:setColor("black")
            selectedCategory = label:getText()
            selectedNumeration = 1
        end
    end
end

function onReceiveDungeonMissions(buffer)
    local param = buffer:split("@")
    local missions_image = tostring(param[1])
    local title = tostring(param[2])
    local players_count = tonumber(param[3])
    local numeration = tonumber(param[4])
    local salas_disponiveis = tostring(param[5])

    local image = g_ui.createWidget("UIButton", panel_missions)
    image:setSize("460 85")
    image:setImageSource("dungeons/" ..missions_image)

    table.insert(lista3, image)
    table.insert(lista4, "dungeons/" ..missions_image)

    local label = g_ui.createWidget("Label", image)
    label:addAnchor(AnchorTop, "parent", AnchorTop)
    label:addAnchor(AnchorLeft, "parent", AnchorLeft)
    label:setFont("sans-bold-16px")
    label:setColor("black")
    label:setTextAutoResize("true")
    label:setText(title)
    label:setMarginLeft(27)
    label:setMarginTop(9)

    image.onClick = function()
        for i = 1, #lista3 do
            if lista3[i] ~= image then
                lista3[i]:setImageSource(lista4[i])
            end

            local str = string.gsub(missions_image, "_off", "")
            image:setImageSource("dungeons/" ..str)
            selectedNumeration = numeration
        end
    end

    local favorit = g_ui.createWidget("UIButton", image)
    favorit:addAnchor(AnchorTop, "parent", AnchorTop)
    favorit:addAnchor(AnchorLeft, "parent", AnchorLeft)
    favorit:setSize("18 17")
    favorit:setImageSource("no_fav.png")
    favorit:setMarginLeft(430)
    favorit:setMarginTop(10)

    local chest = g_ui.createWidget("UIButton", image)
    chest:addAnchor(AnchorTop, "parent", AnchorTop)
    chest:addAnchor(AnchorLeft, "parent", AnchorLeft)
    chest:setSize("18 17")
    chest:setImageSource("chest.png")
    chest:setMarginLeft(430)
    chest:setMarginTop(35)
    chest:setTooltip("Clique para ver as recompensas")
    chest.onClick = function()
        g_game.getProtocolGame():sendExtendedOpcode(46, selectedCategory.."@"..numeration.."@") -- enviar informacao que de que vai enviar as recompensas
    end

    local ranking = g_ui.createWidget("UIButton", image)
    ranking:addAnchor(AnchorTop, "parent", AnchorTop)
    ranking:addAnchor(AnchorLeft, "parent", AnchorLeft)
    ranking:setSize("18 17")
    ranking:setImageSource("ranking.png")
    ranking:setMarginLeft(430)
    ranking:setMarginTop(60)

    local players = g_ui.createWidget("Label", label)
    players:setColor("black")
    players:setTextOffset("22 4")
    players:setTextAutoResize("true")
    players:addAnchor(AnchorTop, "parent", AnchorTop)
    players:addAnchor(AnchorLeft, "parent", AnchorLeft)
    players:setIcon("player.png")
    players:setIconSize("21 21")
    players:setMarginTop(19)
    players:setMarginLeft(10)

    if players_count == 1 then
        players:setText(players_count .. " player")
    else
        players:setText(players_count .. " players")
    end

    local progressbar = g_ui.createWidget("UIProgressBar", image)
    progressbar:setSize("42 16")
    progressbar:setImageSource("progressbar.png")
    progressbar:addAnchor(AnchorTop, "parent", AnchorTop)
    progressbar:addAnchor(AnchorLeft, "parent", AnchorLeft)
    progressbar:setMarginTop(57)
    progressbar:setMarginLeft(10)

    local salas = g_ui.createWidget("Label", image)
    salas:addAnchor(AnchorTop, "parent", AnchorTop)
	salas:setColor("black")
    salas:addAnchor(AnchorLeft, "parent", AnchorLeft)
    salas:setTextAutoResize("true")
    salas:setText(salas_disponiveis.. " salas disponíveis")
    salas:setMarginTop(57)
    salas:setMarginLeft(60)

    jogar.onClick = function()
        dungeon:hide()
        g_game.getProtocolGame():sendExtendedOpcode(50, selectedCategory.."@"..selectedNumeration.."@") -- enviar informacao de que vai iniciar a DG
    end
end

function onReceiveDungeonItems(buffer)
    local param = buffer:split("@")
    local itemid = tonumber(param[1])
    local count = tonumber(param[2])

    local item = g_ui.createWidget("Item", panel_items)
    item:setImageSource("")
    item:setSize("32 32")
    item:setItemId(itemid)

    local label = g_ui.createWidget("Label", item)
    label:addAnchor(AnchorTop, "parent", AnchorTop)
    label:addAnchor(AnchorLeft, "parent", AnchorLeft)
    label:setText(count .. "x")
    label:setMarginLeft(48)
    label:setMarginTop(26)
end

function onReceiveDungeonInvite(buffer)
    local param = buffer:split("@")
    local name = tostring(param[1])
    local requested_player = tostring(param[2])

    if dungeon:isVisible() == false then
        dungeon:show()
        
        g_game.getProtocolGame():sendExtendedOpcode(44, selectedCategory.."@")
    end

    window_acceptinvite = g_ui.createWidget("DungeonAcceptInvite", dungeon)
    window_acceptinvite:setTextOffset("0 30")
    window_acceptinvite:setText(name .. " te convidou a dungeon, deseja aceitar?")

    window_button = g_ui.createWidget("UIButton", window_acceptinvite)
    window_button:addAnchor(AnchorTop, "parent", AnchorTop)
    window_button:addAnchor(AnchorLeft, "parent", AnchorLeft)
    window_button:setSize("99 24")
    window_button:setImageSource("invite/aceitar.png")
    window_button:setMarginTop(145)
    window_button:setMarginLeft(65)
    window_button:setOpacity(0.50)
    window_button.onHoverChange = function(self, hovered) 
        if hovered then 
            window_button:setOpacity(100)
        else 
            window_button:setOpacity(0.50) 
        end 
    end

    window_button.onClick = function()
        if window_acceptinvite then
            window_acceptinvite:hide()
            window_acceptinvite = nil
        end

        g_game.getProtocolGame():sendExtendedOpcode(48, name.."@") -- informacao que vai enviar: aceitar pedido
    end

    window_button2 = g_ui.createWidget("UIButton", window_acceptinvite)
    window_button2:addAnchor(AnchorTop, "parent", AnchorTop)
    window_button2:addAnchor(AnchorLeft, "parent", AnchorLeft)
    window_button2:setSize("99 24")
    window_button2:setImageSource("invite/cancelar.png")
    window_button2:setMarginTop(145)
    window_button2:setMarginLeft(170)
    window_button2:setOpacity(0.50)
    window_button2.onHoverChange = function(self, hovered) 
        if hovered then 
            window_button2:setOpacity(100)
        else 
            window_button2:setOpacity(0.50) 
        end 
    end

    window_button2.onClick = function()
        if window_acceptinvite then
            window_acceptinvite:hide()
            window_acceptinvite = nil
        end

        g_game.getProtocolGame():sendExtendedOpcode(49, name.."@") -- informacao que vai enviar: negar pedido
    end
end

function onReceiveDungeonParty(buffer)
    local param = buffer:split("@")
    local name = tostring(param[1])
    local level = tonumber(param[2])
    local healthPercent = tonumber(param[3])

    local lbl = g_ui.createWidget("Label", panel_team)
    lbl:setText("Nome: " .. name .. "\nNível: " .. level .. "\nVida: " .. healthPercent)
    lbl:setTextAutoResize("true")
    lbl:setMarginLeft(110)
    lbl:setMarginTop(50)
end

function addPlayersOnMyTeam()
    if window_invite then return end
    if window_acceptinvite then return end
    window_invite = g_ui.createWidget("DungeonInvite", dungeon)

    window_text = g_ui.createWidget("DungeonText", dungeon)
    window_text:setCursorPos(-1)
    window_text:setSize("207 20")
    window_text:addAnchor(AnchorTop, "parent", AnchorTop)
    window_text:addAnchor(AnchorLeft, "parent", AnchorLeft)
    window_text:setMarginTop(242)
    window_text:setMarginLeft(360)

    window_button = g_ui.createWidget("UIButton", window_invite)
    window_button:addAnchor(AnchorTop, "parent", AnchorTop)
    window_button:addAnchor(AnchorLeft, "parent", AnchorLeft)
    window_button:setSize("99 24")
    window_button:setImageSource("invite/enviar.png")
    window_button:setMarginTop(145)
    window_button:setMarginLeft(65)
    window_button:setOpacity(0.50)
    window_button.onHoverChange = function(self, hovered) 
        if hovered then 
            window_button:setOpacity(100)
        else 
            window_button:setOpacity(0.50) 
        end 
    end

    window_button.onClick = function()
        if window_text:getText() == nil or window_text:getText() == "" then
            displayErrorBox(tr('Error'), "Você precisa digitar um nome de jogador válido.")
            return
        end

        g_game.getProtocolGame():sendExtendedOpcode(47, window_text:getText().."@") -- enviar informacao para convidar players

        if window_invite then 
            window_invite:hide()
            window_text:hide()
    
            window_invite = nil
        end
    end

    window_button2 = g_ui.createWidget("UIButton", window_invite)
    window_button2:addAnchor(AnchorTop, "parent", AnchorTop)
    window_button2:addAnchor(AnchorLeft, "parent", AnchorLeft)
    window_button2:setSize("99 24")
    window_button2:setImageSource("invite/cancelar.png")
    window_button2:setMarginTop(145)
    window_button2:setMarginLeft(170)
    window_button2:setOpacity(0.50)
    window_button2.onHoverChange = function(self, hovered) 
        if hovered then 
            window_button2:setOpacity(100)
        else 
            window_button2:setOpacity(0.50) 
        end 
    end

    window_button2.onClick = function()
        if window_invite then 
            window_invite:hide()
            window_text:hide()
    
            window_invite = nil
        end
    end

    window_text.onTextChange = function(self, value)
        if value == nil or value == "" or value:len() < 5 then
            window_button:setOpacity(0.50)
        end

        if value ~= nil and value ~= "" and value:len() >= 5 then
            window_button:setOpacity(100)
        end
    end
end