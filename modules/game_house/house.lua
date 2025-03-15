-- Criado por Thalles Vitor --
-- House Window otPokemon.com --

local house = g_ui.displayUI("house")
local house_ownername = house:getChildById("owner_name") 
local house_beds = house:getChildById("beds_count")
local house_price = house:getChildById("price_required")
local buy_house = house:getChildById("buy_house")
local invite_houseBtn = house:getChildById("invite_houseBtn")
local acessdoors = house:getChildById("acessdoors")
local housesublider = house:getChildById("housesublider")
local leaveHouseBtnn = house:getChildById("leaveHouseBtnn")

function init()
  connect(g_game, {
    --onGameStart = exibir,
    onGameEnd = naoexibir,
  })

  house:hide()
end

function terminate()
  disconnect(g_game, {
    onGameEnd = naoexibir,
  })

  house:hide()
end

function exibir()
  house:show()
end

function naoexibir()
  house:hide()
end

ProtocolGame.registerExtendedOpcode(76, function(protocol, opcode, buffer) -- receive house window
  local param = buffer:split("@")

  if param[1] == "houseWindow" then
    local owner = param[2]
    local price = tonumber(param[3])
    local beds = tonumber(param[4])
    local name = param[5]
	
	if g_game.getLocalPlayer():getName() ~= name then
		buy_house:show()
		invite_houseBtn:hide()
		acessdoors:hide()
		housesublider:hide()
		leaveHouseBtnn:hide()
	end
	
	if g_game.getLocalPlayer():getName() == name then
		buy_house:hide()
		invite_houseBtn:show()
		acessdoors:show()
		housesublider:show()
		leaveHouseBtnn:show()
	end

    -- Exibir Janela
    exibir()

    -- Setar informações
    house_ownername:setText(owner)
    house:setText(name)
    house_beds:setText(beds)
    house_price:setText(price.. " Yens")
  end
end)