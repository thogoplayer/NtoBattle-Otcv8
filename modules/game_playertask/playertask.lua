-- Criado por Thalles Vitor --
-- Module de Task --
local playertask = g_ui.displayUI("playertask")
local points_lbl = playertask:getChildById("points")
local ranksPanel = playertask:getChildById("ranksPanel")
local monsters_hunter = playertask:getChildById("monsters_hunter")
local playertask_button = nil

-- Informacoes (Recebidas)
    local taskOPCODE_WINDOW = 122 -- opcode que vai receber a janela da task com as infos (monstros, pontos, exp)
    local taskOPCODE_WINDOW_DESTROYINFOS = 123 -- opcode que vai destruir as informacoes anteriores
    local taskOPCODE_WINDOW_RANKS = 124 -- opcode que vai receber a janela da task com as infos (ranks)
--

-- Informacoes (Recebidas)
    local taskOPCODE_sendINFOS = 67 -- opcode que vai enviar para o servidor sinalizando que precisa enviar as informacoes de volta pro cliente
    local taskOPCODE_sendChangeRank = 68 -- opcode que vai enviar para o servidor sinalizando que esta trocando o ranking
    local taskOPCODE_sendAcceptOption = 69 -- opcode que vai enviar para o servidor sinalizando que ele deve aceitar a task
    local taskOPCODE_sendCollectReward = 70 -- opcode que vai enviar para o servidor sinalizando que ele deve coletar a recompensa
    local taskOPCODE_sendCancelTask = 71 -- opcode que vai enviar para o servidor sinalizando que ele deve cancelar a task
--

-- Tabelas
rank_widgets = {} -- armazenar os widgets (rank)
rank_widgets_image = {} -- armazenar imagens do widgets (rank)
selectedRanking = "E" -- ranking selecionado

local recompenses = {
    ["E"] =
    {
        [1] = {recompenseList = {16281}, count = {50}},
		[2] = {recompenseList = {16281}, count = {50}},
		[3] = {recompenseList = {16281}, count = {50}},
		[4] = {recompenseList = {16281}, count = {50}},
		[5] = {recompenseList = {16281}, count = {50}},
		[6] = {recompenseList = {16281}, count = {50}},
		[7] = {recompenseList = {16281}, count = {50}},

    },

    ["D"] =
    {
	    [8] = {recompenseList = {17070, 9448}, count = {1, 10}},
		[9] = {recompenseList = {17070, 9447}, count = {1, 10}},
		[10] = {recompenseList = {17070, 9447}, count = {1, 10}},
		[11] = {recompenseList = {17070, 9448}, count = {1, 10}},
		[12] = {recompenseList = {17070, 9448}, count = {1, 10}},
		[13] = {recompenseList = {17070, 9448}, count = {1, 10}},
		[14] = {recompenseList = {17070, 9447}, count = {1, 10}},
		[15] = {recompenseList = {17070, 9447}, count = {1, 10}},
	
    },
	
    ["C"] =
    {
        [16] = {recompenseList = {11832, 19683, 21171}, count = {5, 3, 10}},
    },
	
    ["B"] =
    {
        [17] = {recompenseList = {11832, 19683, 21171}, count = {5, 3, 10}},
    },
	
    ["A"] =
    {
        [18] = {recompenseList = {11832, 19683, 21171}, count = {5, 3, 10}},
    },
	
    ["S"] =
    {
        [19] = {recompenseList = {11832, 19683, 21171}, count = {5, 3, 10}},
    }

}

function init()
    connect(g_game, {
        onGameStart = naoexibir,
        onGameEnd = naoexibir,
    })

    playertask_button = modules.client_topmenu.addLeftGameToggleButton('taskButton', tr('Task'), 'task.png', exibir)
    playertask_button:setOn(false)

    playertask:hide()
    ProtocolGame.registerExtendedOpcode(taskOPCODE_WINDOW, function(protocol, opcode, buffer) onReceivePlayerTasks(buffer) end)
    ProtocolGame.registerExtendedOpcode(taskOPCODE_WINDOW_DESTROYINFOS, function(protocol, opcode, buffer) onReceiveDestroyInfos(buffer) end)
    ProtocolGame.registerExtendedOpcode(taskOPCODE_WINDOW_RANKS, function(protocol, opcode, buffer) onReceivePlayerRanks(buffer) end)
end

function terminate()
    disconnect(g_game, {
        onGameStart = naoexibir,
        onGameEnd = naoexibir,
    })

    ProtocolGame.unregisterExtendedOpcode(taskOPCODE_WINDOW)
    ProtocolGame.unregisterExtendedOpcode(taskOPCODE_WINDOW_DESTROYINFOS)
    ProtocolGame.unregisterExtendedOpcode(taskOPCODE_WINDOW_RANKS)
    playertask:hide()
end

function exibir()
    if playertask_button:isOn() then
        playertask_button:setOn(false)
        playertask:hide()

        selectedRanking = "E"
    else
        playertask_button:setOn(true)
        playertask:show()

        if g_game.isOnline() then
            g_game.getProtocolGame():sendExtendedOpcode(taskOPCODE_sendINFOS)
        end
    end
end

function naoexibir()
    playertask_button:setOn(false)
    playertask:hide()

    selectedRanking = "E"
end

function onReceivePlayerTasks(buffer)
    local param = buffer:split("@")
    local background = tostring(param[1])
    local outfit_monster = tonumber(param[2])
    local name_monster = tostring(param[3])
    local count_player = tonumber(param[4])
    local count_monster = tonumber(param[5])
    local description_monster = tostring(param[6])
    local level_monster = tonumber(param[7])
    local exp_monster = tonumber(param[8])
    local points_monster = tonumber(param[9])
    local rank = tostring(param[10])
    local numeration = tonumber(param[11])
    local status = tostring(param[12])
    local type = tostring(param[13])
    local pontos = tonumber(param[14])
	local nometask = tostring(param[15])
	
    local recompense_table = {}
    points_lbl:setText(pontos)

    local monsters_background = g_ui.createWidget("UIButton", monsters_hunter)
    monsters_background:setSize("619 145")
    monsters_background:setImageSource(background)

    local slot = g_ui.createWidget("UIButton", monsters_background)
    slot:addAnchor(AnchorTop, "parent", AnchorTop)
    slot:addAnchor(AnchorLeft, "parent", AnchorLeft)
    slot:setMarginLeft(17)
    slot:setMarginTop(13)
    slot:setSize("71 71")
    slot:setImageSource("images/slot.png")

    local outfit = g_ui.createWidget("Creature", slot)
    outfit:addAnchor(AnchorTop, "parent", AnchorTop)
    outfit:addAnchor(AnchorLeft, "parent", AnchorLeft)
    outfit:setMarginLeft(-18)
    outfit:setMarginTop(-10)
    outfit:setSize("64 64")
    outfit:setImageSource("")
    outfit:setOutfit({type = outfit_monster})

    local name = g_ui.createWidget("Label", monsters_background)
    name:addAnchor(AnchorTop, "parent", AnchorTop)
    name:addAnchor(AnchorLeft, "parent", AnchorLeft)
    name:setMarginTop(18)
    name:setMarginLeft(92)
    name:setColor("white")
    name:setTextAutoResize("true")
    name:setFont("sans-bold-16px")
    name:setText(nometask .. " - " .. count_player .. "/" .. count_monster .. " (" .. type .. ")")

    local description = g_ui.createWidget("Label", monsters_background)
    description:addAnchor(AnchorTop, "parent", AnchorTop)
    description:addAnchor(AnchorLeft, "parent", AnchorLeft)
    description:setMarginLeft(92)
    description:setMarginTop(39)
    description:setColor("white")
    description:setTextAutoResize("true")
    description:setFont("terminus-14px-bold")
    description:setText(description_monster)

    if level_monster > 0 then
        local level = g_ui.createWidget("Label", monsters_background)
        level:addAnchor(AnchorTop, "parent", AnchorTop)
        level:addAnchor(AnchorLeft, "parent", AnchorLeft)
        level:setMarginTop(64)
        level:setMarginLeft(35)
        level:setColor("white")
        level:setText("Lv." .. level_monster)
    end

    local exp = g_ui.createWidget("Label", monsters_background)
    exp:addAnchor(AnchorTop, "parent", AnchorTop)
    exp:addAnchor(AnchorLeft, "parent", AnchorLeft)
    exp:setMarginTop(102)
    exp:setMarginLeft(55)
    exp:setTextAutoResize("true")
    exp:setColor("white")
    exp:setText("Experiência: " ..exp_monster .. "+")

    local points = g_ui.createWidget("Label", monsters_background)
    points:addAnchor(AnchorTop, "parent", AnchorTop)
    points:addAnchor(AnchorLeft, "parent", AnchorLeft)
    points:setMarginTop(122)
    points:setMarginLeft(55)
    points:setTextAutoResize("true")
    points:setColor("white")
    points:setText("Pontos de caça: " ..points_monster)

    if status == "noaccepted" then
        local accept_button = g_ui.createWidget("UIButton", monsters_background)
        accept_button:addAnchor(AnchorTop, "parent", AnchorTop)
        accept_button:addAnchor(AnchorLeft, "parent", AnchorLeft)
        accept_button:setMarginTop(2)
        accept_button:setMarginLeft(546)
        accept_button:setSize("77 142")
        accept_button:setImageSource("images/accept.png")
        accept_button.onHoverChange = function(self, hovered)
            if hovered then
                accept_button:setImageSource("images/accept_hover.png")
            else
                accept_button:setImageSource("images/accept.png")
            end
        end

        accept_button.onClick = function() 
            g_game.getProtocolGame():sendExtendedOpcode(taskOPCODE_sendAcceptOption, name_monster.."@"..rank.."@")
        end
    elseif status == "accepted" then
        local coletar = g_ui.createWidget("UIButton", monsters_background)
        coletar:addAnchor(AnchorTop, "parent", AnchorTop)
        coletar:addAnchor(AnchorLeft, "parent", AnchorLeft)
        coletar:setMarginTop(2)
        coletar:setMarginLeft(546)
        coletar:setSize("77 71")
        coletar:setImageSource("images/coletar.png")
        coletar:setTooltip("Clique aqui para coletar sua recompensa")
        coletar.onHoverChange = function(self, hovered)
            if hovered then
                coletar:setImageSource("images/coletar.png")
            else
                coletar:setImageSource("images/coletar.png")
            end
        end

        coletar.onClick = function()
            g_game.getProtocolGame():sendExtendedOpcode(taskOPCODE_sendCollectReward, name_monster.."@"..rank.."@")
        end

        local cancelar = g_ui.createWidget("UIButton", monsters_background)
        cancelar:addAnchor(AnchorTop, "parent", AnchorTop)
        cancelar:addAnchor(AnchorLeft, "parent", AnchorLeft)
        cancelar:setMarginTop(73)
        cancelar:setMarginLeft(546)
        cancelar:setSize("77 71")
        cancelar:setImageSource("images/cancelar.png")
        cancelar:setTooltip("Clique aqui para cancelar essa task")
        cancelar.onHoverChange = function(self, hovered)
            if hovered then
                cancelar:setImageSource("images/cancelar.png")
            else
                cancelar:setImageSource("images/cancelar_hover.png")
            end
        end

        cancelar.onClick = function()
            g_game.getProtocolGame():sendExtendedOpcode(taskOPCODE_sendCancelTask, name_monster.."@"..rank.."@")
        end
    end

    local recompenses_panel = g_ui.createWidget("ItemsPanel", monsters_background)
    recompenses_panel:setSize("286 31")
    recompenses_panel:addAnchor(AnchorTop, "parent", AnchorTop)
    recompenses_panel:addAnchor(AnchorLeft, "parent", AnchorLeft)
    recompenses_panel:setMarginTop(900)
    recompenses_panel:setMarginLeft(900)

    if recompenses[rank] and recompenses[rank][numeration] then
        for i = 1, #recompenses[rank][numeration].recompenseList do
            local recompense_slots = g_ui.createWidget("Item", recompenses_panel)
			recompense_slots:addAnchor(AnchorTop, "parent", AnchorTop)
			recompense_slots:addAnchor(AnchorLeft, "parent", AnchorLeft)
            recompense_slots:setId("recompenses"..i)
            recompense_slots:setImageSource("images/slotitem.png")
            recompense_slots:setSize("30 30")
            recompense_slots:setItemId(recompenses[rank][numeration].recompenseList[i])
            recompense_slots:setTooltip("Quantidade de prêmios: " ..recompenses[rank][numeration].count[i] .. "x")
        end
    end
end

function onReceiveDestroyInfos(buffer)
    local param = buffer:split("@")
    local type = tostring(param[1])

    if type == "rankings" then
        ranksPanel:destroyChildren()
    end

    if type == "monsters" then
        monsters_hunter:destroyChildren()
    end
end

function onReceivePlayerRanks(buffer)
    local param = buffer:split("@")
    local ranks = tostring(param[1])
    local numeration = tonumber(param[2])
    local hasLocked = tostring(param[3])

    local rank_widget = g_ui.createWidget("UIButton", ranksPanel)
    rank_widget:setId("rank"..numeration)
    rank_widget:setSize("152 26")
    rank_widget:setImageSource("images/ranks/" .. ranks .. "-blue.png")

    if ranks == "E" and selectedRanking == "E" then
        rank_widget:setImageSource("images/ranks/" .. ranks .. "-red.png")
    end

    if selectedRanking == ranks then
        rank_widget:setImageSource("images/ranks/" .. selectedRanking .. "-red.png")
    end

    if hasLocked == "locked" then
        rank_widget:setImageSource("images/locked.png")
    end

    if hasLocked ~= "locked" then
        rank_widgets[numeration] = rank_widget
        rank_widgets_image[numeration] = "images/ranks/" .. ranks .. "-blue.png"
    end

    if hasLocked ~= "locked" then
        rank_widget.onClick = function()
            for i = 1, #rank_widgets do
                if rank_widgets[i] ~= rank_widget then
                    rank_widgets[i]:setImageSource(rank_widgets_image[i])
                end
            end

            rank_widget:setImageSource("images/ranks/" .. ranks .. "-red.png")
            selectedRanking = ranks
            g_game.getProtocolGame():sendExtendedOpcode(taskOPCODE_sendChangeRank, selectedRanking.."@")
        end
    end
end