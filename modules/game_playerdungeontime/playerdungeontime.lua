-- Criado por Thalles Vitor --
-- Module de Dungeon --
local dungeon = g_ui.displayUI("playerdungeontime")
local time = dungeon:getChildById("time")
local monsters = dungeon:getChildById("monsters")

-- Informacoes
    local dungeonOPCODE_TIMEWINDOW = 94 -- opcode que vai receber a janela de tempo
    local dungeonOPCODE_TIMEWINDOW_HIDE = 95 -- opcode que vai ocultar a janela de tempo
--

time_list = {} -- lista de tempo

function init()
    connect(g_game, {
        onGameStart = naoexibir,
        onGameEnd = naoexibir,
    })

    dungeon:hide()
    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_TIMEWINDOW, function(protocol, opcode, buffer) onReceiveDungeonTime(buffer) end)
    ProtocolGame.registerExtendedOpcode(dungeonOPCODE_TIMEWINDOW_HIDE, function(protocol, opcode, buffer) onHideDungeonTime(buffer) end)
end

function terminate()
    disconnect(g_game, {
        onGameStart = naoexibir,
        onGameEnd = naoexibir,
    })

    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_TIMEWINDOW)
    ProtocolGame.unregisterExtendedOpcode(dungeonOPCODE_TIMEWINDOW_HIDE)
    dungeon:hide()
end

function naoexibir()
    dungeon:hide()
end

function onReceiveDungeonTime(buffer)
    local param = buffer:split("@")
    local time_numb = tonumber(param[1])
    local monster = tostring(param[2])
    table.insert(time_list, time_numb)

    dungeon:show()
    time:setText(os.date("%M:%S", time_numb - os.time()))
    monsters:setText(monster)

    cycleEvent(updateDungeonTime, 1000)
end

function onHideDungeonTime(buffer)
    local param = buffer:split("@")
    dungeon:hide()
end

function updateDungeonTime()
    for i = 1, #time_list do
        time:setText(os.date("%M:%S", time_list[i] - os.time()))
    end
end