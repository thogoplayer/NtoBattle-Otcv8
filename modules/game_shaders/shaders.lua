shadersPanel = nil
local toggleShaderEvent
local eventTime
local lastShader


SHADERS = {--area opcodes
	{fromPos = {x = 2360, y = 3046, z = 6}, toPos = {x = 2391, y = 3084, z = 7}, opcode_name = "map_shakescreen"},
	{fromPos = {x = 2416, y = 3096, z = 7}, toPos = {x = 2447, y = 3131, z = 7}, opcode_name = "map_rain"},
	-- {fromPos = {x = 2310, y = 3097, z = 7}, toPos = {x = 2340, y = 3133, z = 7}, opcode_name = "map_heavyrainlightning"},
	{fromPos = {x = 2310, y = 3097, z = 7}, toPos = {x = 2340, y = 3133, z = 7}, opcode_name = "map_distortion"},
	-- {fromPos = {x = 2064, y = 2063, z = 6}, toPos = {x = 2067, y = 2065, z = 6}, opcode_name = "map_grayscale"},
	
}


function init()

	-------- MAP
	g_shaders.createShader("map_default", "/shaders/map_default_vertex", "/shaders/map_default_fragment")  
	---
	g_shaders.createShader("map_heat", "/shaders/map_rainbow_vertex", "/shaders/heat")
	g_shaders.createShader("map_bloom", "/shaders/map_rainbow_vertex", "/shaders/bloom")
	g_shaders.createShader("map_fog", "/shaders/map_default_vertex", "/shaders/fog")
	g_shaders.createShader("map_grayscale", "/shaders/map_rainbow_vertex", "/shaders/grayscale")
	g_shaders.createShader("map_noise", "/shaders/map_rainbow_vertex", "/shaders/noise")
	g_shaders.createShader("map_oldtv", "/shaders/map_rainbow_vertex", "/shaders/oldtv")
	g_shaders.createShader("map_party", "/shaders/map_rainbow_vertex", "/shaders/party")
	g_shaders.createShader("map_pulse", "/shaders/map_rainbow_vertex", "/shaders/pulse")
	g_shaders.createShader("map_radialblur", "/shaders/map_rainbow_vertex", "/shaders/radialblur")
	g_shaders.createShader("map_sepia", "/shaders/map_rainbow_vertex", "/shaders/sepia")
	g_shaders.createShader("map_snow", "/shader/map/map_heavy_snow_vertex", "/shaders/snow")
	g_shaders.addTexture("map_snow", "/shader/map/textures/heavy_snow.png")
	g_shaders.createShader("map_zomg", "/shaders/map_rainbow_vertex", "/shaders/zomg")
	g_shaders.createShader("map_distortion", "/shader/map/map_default_vertex", "/shader/map/map_distortion_fragment")
	g_shaders.createShader("map_sepiadois", "/shader/map/map_default_vertex", "/shader/map/map_filter_sepia")
	g_shaders.createShader("map_shakescreen", "/shaders/map_shakescreen_vertex", "/shaders/map_shakescreen_fragment")
	
	
	--- com textura
	g_shaders.createShader("map_rain", "/shaders/map_rainbow_vertex", "/shaders/rain")
	g_shaders.addTexture("map_rain", "/images/shaders/rain.png")
	g_shaders.addTexture("map_rain", "/shader/map/textures/lightning.png")
	
	g_shaders.createShader("map_rainbow", "/shaders/map_rainbow_vertex", "/shaders/map_rainbow_fragment")
	g_shaders.addTexture("map_rainbow", "/images/shaders/rainbow.png")
	
	------- Não Funcionou
	g_shaders.createShader("map_lightfog", "/shader/map/map_light_fog_vertex", "/shader/map/map_light_fog_fragment")
	g_shaders.addTexture("map_lightfog", "/images/shaders/lightfog.png")
	
	g_shaders.createShader("map_heavyfog", "/shader/map/map_heavy_fog_vertex", "/shader/map/map_heavy_fog_fragment")
	g_shaders.addTexture("map_heavyfog", "/shader/map/textures/heavy_fog.png")
	
	g_shaders.createShader("map_lightrain", "/shader/map/map_light_rain_vertex", "/shader/map/map_light_rain_fragment")
	g_shaders.addTexture("map_lightrain", "/shader/map/textures/light_rain.png")
	g_shaders.addTexture("map_lightrain", "/shader/map/textures/light_fog.png")
	
	g_shaders.createShader("map_heavyrain", "/shader/map/map_heavy_rain_vertex", "/shader/map/map_heavy_rain_fragment")
	g_shaders.addTexture("map_heavyrain", "/shader/map/textures/heavy_rain.png")
	g_shaders.addTexture("map_heavyrain", "/shader/map/textures/heavy_fog.png")
	
	g_shaders.createShader("map_lightsandstorm", "/shader/map/map_light_sandstorm_vertex", "/shader/map/map_light_sandstorm_fragment")
	g_shaders.addTexture("map_lightsandstorm", "/shader/map/textures/light_sandstorm.png")
	g_shaders.addTexture("map_lightsandstorm", "/shader/map/textures/sand_fog.png")
	
	g_shaders.createShader("map_heavysandstorm", "/shader/map/map_heavy_sandstorm_vertex", "/shader/map/map_heavy_sandstorm_fragment")
	g_shaders.addTexture("map_heavysandstorm", "/shader/map/textures/heavy_sandstorm.png")
	g_shaders.addTexture("map_heavysandstorm", "/shader/map/textures/sand_fog.png")
	
	g_shaders.createShader("map_lightsnow", "/shader/map/map_light_snow_vertex", "/shader/map/map_light_snow_fragment")
	g_shaders.addTexture("map_lightsnow", "/shader/map/textures/light_snow.png")
	g_shaders.addTexture("map_lightsnow", "/shader/map/textures/light_fog.png")
	
	g_shaders.createShader("map_heavysnow", "/shader/map/map_heavy_snow_vertex", "/shader/map/map_heavy_snow_fragment")
	g_shaders.addTexture("map_heavysnow", "/shader/map/textures/heavy_snow.png")
	g_shaders.addTexture("map_heavysnow", "/shader/map/textures/light_fog.png")
	
	--esse apareceu só o raio
	g_shaders.createShader("map_heavyrainlightning", "/shader/map/map_heavy_rain_lightning_vertex", "/shader/map/map_heavy_rain_lightning_fragment")
	g_shaders.addTexture("map_heavyrainlightning", "/shader/map/textures/heavy_rain.png")
	g_shaders.addTexture("map_heavyrainlightning", "/shader/map/textures/heavy_fog.png")
	g_shaders.addTexture("map_heavyrainlightning", "/shader/map/textures/lightning.png")
	
	---esse só distorceu
	g_shaders.createShader("map_lightsandstormdistortion", "/shader/map/map_light_sandstorm_vertex", "/shader/map/map_light_sandstorm_distortion_fragment")
	g_shaders.addTexture("map_lightsandstormdistortion", "/shader/map/textures/light_sandstorm.png")
	
	g_shaders.createShader("map_heavysandstormdistortion", "/shader/map/map_heavy_sandstorm_vertex", "/shader/map/map_heavy_sandstorm_distortion_fragment")
	g_shaders.addTexture("map_heavysandstormdistortion", "/shader/map/textures/heavy_sandstorm.png")
	
	-------- Others não testei
	g_shaders.createShader("ShaderWidgetGlow", "/shader/widget/widget_default_vertex", "/shader/widget/pepega")
	g_shaders.createShader("ShaderAetherEnhancement", "/shader/effects/aether_enhancement_vertex", "/shader/effects/aether_enhancement_fragment", true)
	

	-------- Outfit 
	g_shaders.createOutfitShader("outfit_default", "/shaders/outfit_default_vertex", "/shaders/outfit_default_fragment")
	---
	g_shaders.createOutfitShader("outfit_rainbow", "/shaders/outfit_rainbow_vertex", "/shaders/outfit_rainbow_fragment")
	g_shaders.addTexture("outfit_rainbow", "/images/shaders/rainbow.png")
	  
	g_shaders.createOutfitShader("outfit_heat", "/shaders/outfit_rainbow_vertex", "/shaders/outfit_heat_fragment")	  
	g_shaders.createOutfitShader("outfit_party", "/shaders/outfit_rainbow_vertex", "/shaders/outfit_party_fragment")
	
	--- novos lines
	g_shaders.createOutfitShader("ShaderLightBlue", "/shader/outline/outline_vertex", "/shader/outline/outline_light_blue_fragment")
	g_shaders.createOutfitShader("ShaderBlue", "/shader/outline/outline_vertex", "/shader/outline/outline_blue_fragment")
	g_shaders.createOutfitShader("ShaderRed", "/shader/outline/outline_vertex", "/shader/outline/outline_red_fragment")
	g_shaders.createOutfitShader("ShaderDarkRed", "/shader/outline/outline_vertex", "/shader/outline/outline_dark_red_fragment")
	g_shaders.createOutfitShader("ShaderPurple", "/shader/outline/outline_vertex", "/shader/outline/outline_purple_fragment")
	g_shaders.createOutfitShader("ShaderWhite", "/shader/outline/outline_vertex", "/shader/outline/outline_white_fragment")
	g_shaders.createOutfitShader("ShaderLightBlueStatic", "/shader/outline/outline_vertex", "/shader/outline/outline_light_blue_static_fragment")
	g_shaders.createOutfitShader("ShaderBlueStatic", "/shader/outline/outline_vertex", "/shader/outline/outline_blue_static_fragment")
	g_shaders.createOutfitShader("ShaderRedStatic", "/shader/outline/outline_vertex", "/shader/outline/outline_red_static_fragment")
	g_shaders.createOutfitShader("ShaderDarkRedStatic", "/shader/outline/outline_vertex", "/shader/outline/outline_dark_red_static_fragment")
	g_shaders.createOutfitShader("ShaderPurpleStatic", "/shader/outline/outline_vertex", "/shader/outline/outline_purple_static_fragment")
	g_shaders.createOutfitShader("ShaderWhiteStatic", "/shader/outline/outline_vertex", "/shader/outline/outline_white_static_fragment")
	g_shaders.createOutfitShader("ShaderRage", "/shader/outline/outline_vertex", "/shader/outline/rage_shader")
	g_shaders.createOutfitShader("ShaderFreeze", "/shader/outline/outline_vertex", "/shader/outline/freeze_shader")
	g_shaders.createOutfitShader("ShaderGreen", "/shader/outline/outline_vertex", "/shader/outline/outline_green_fragment")
	g_shaders.createOutfitShader("ShaderGreenStatic", "/shader/outline/outline_vertex", "/shader/outline/outline_green_static_fragment")
	g_shaders.createOutfitShader("ShaderYellow", "/shader/outline/outline_vertex", "/shader/outline/outline_yellow_fragment")
	g_shaders.createOutfitShader("ShaderYellowStatic", "/shader/outline/outline_vertex", "/shader/outline/outline_yellow_static_fragment")
	g_shaders.createOutfitShader("ShaderCreatureHighlight", "/shader/outline/outline_vertex", "/shader/outline/creature_highlight")
	
	g_shaders.createOutfitShader("Outfit_3line", "/shader/outfit/outfit_3line_vertex", "/shader/outfit/outfit_3line_fragment")
	g_shaders.createOutfitShader("Outfit_circle", "/shader/outfit/outfit_circle_vertex", "/shader/outfit/outfit_circle_fragment")
	g_shaders.createOutfitShader("Outfit_Line", "/shader/outfit/outfit_line_vertex", "/shader/outfit/outfit_line_fragment")
	g_shaders.createOutfitShader("Outfit_Outline", "/shader/outfit/outfit_outline_vertex", "/shader/outfit/outfit_outline_fragment")
	g_shaders.createOutfitShader("Outfit_Shimmering", "/shader/outfit/outfit_shimmering_vertex", "/shader/outfit/outfit_shimmering_fragment")
	g_shaders.createOutfitShader("Outfit_Shine", "/shader/outfit/outfit_shine_vertex", "/shader/outfit/outfit_shine_fragment")
	
	
	
	
	--- com textura
	g_shaders.createOutfitShader("Outfit_brazil", "/shader/outfit/outfit_brazil_vertex", "/shader/outfit/outfit_brazil_fragment")
	g_shaders.addTexture("Outfit_brazil", "/images/shaders/brazil.png")
		
	g_shaders.createOutfitShader("Outfit_Gold", "/shader/outfit/outfit_gold_vertex", "/shader/outfit/outfit_gold_fragment")
	g_shaders.addTexture("outfit_rainbow", "/images/shaders/gold.png")
	
	g_shaders.createOutfitShader("Outfit_Stars", "/shader/outfit/outfit_stars_vertex", "/shader/outfit/outfit_stars_fragment")
	g_shaders.addTexture("Outfit_Stars", "/images/shaders/stars.png")
	
	g_shaders.createOutfitShader("Outfit_Sweden", "/shader/outfit/outfit_sweden_vertex", "/shader/outfit/outfit_sweden_fragment")
	g_shaders.addTexture("Outfit_Sweden", "/images/shaders/sweden.png")
	
	--- FALTA TEXTURA
	g_shaders.createOutfitShader("Outfit_blood", "/shader/outfit/outfit_blood_vertex", "/shader/outfit/outfit_blood_fragment")
	g_shaders.createOutfitShader("Outfit_camouflage", "/shader/outfit/outfit_camouflage_vertex", "/shader/outfit/outfit_camouflage_fragment")
	g_shaders.createOutfitShader("Outfit_Flash", "/shader/outfit/outfit_flash_vertex", "/shader/outfit/outfit_flash_fragment")
	g_shaders.createOutfitShader("Outfit_Glitch", "/shader/outfit/outfit_glitch_vertex", "/shader/outfit/outfit_glitch_fragment")
	g_shaders.createOutfitShader("Outfit_Ice", "/shader/outfit/outfit_ice_vertex", "/shader/outfit/outfit_ice_fragment")
	g_shaders.createOutfitShader("Outfit_Purpleneon", "/shader/outfit/outfit_purpleneon_vertex", "/shader/outfit/outfit_purpleneon_fragment")
	g_shaders.createOutfitShader("Outfit_Cosmos", "/shader/outfit/outfit_cosmos_vertex", "/shader/outfit/outfit_cosmos_fragment")
	g_shaders.createOutfitShader("Outfit_Purplesky", "/shader/outfit/outfit_purplesky_vertex", "/shader/outfit/outfit_purplesky_fragment")
	g_shaders.createOutfitShader("Outfit_Static", "/shader/outfit/outfit_static_vertex", "/shader/outfit/outfit_static_fragment")
	g_shaders.createOutfitShader("Outfit_Sun", "/shader/outfit/outfit_sun_vertex", "/shader/outfit/outfit_sun_fragment")

	
  g_ui.importStyle('shaders.otui')

  shadersPanel = g_ui.createWidget('ShadersPanel', modules.game_interface.getMapPanel())
  shadersPanel:hide()

  local mapComboBox = shadersPanel:getChildById('mapComboBox')
  mapComboBox.onOptionChange = function(combobox, option)
   modules.game_interface.gameMapPanel:setShader(option)
  end

  modules.game_interface.gameMapPanel:setShader("map_default")
  eventTime = cycleEvent(iniciar, 1000)
end

ProtocolGame.registerExtendedOpcode(65, function (protocol, opcode, buffer) 
    modules.game_interface.gameMapPanel:setShader(buffer)
end)

function terminate()
  eventTime = cycleEvent(iniciar, 1000)
  shadersPanel:destroy()
end

function toggle()
  shadersPanel:setVisible(not shadersPanel:isVisible())
end

function iniciar()
	if (g_game.isOnline()) then
		removeEvent(e)
		toggleShaderEvent = addEvent(startShader, 1000)
	end
end

function startShader()
  local player = g_game.getLocalPlayer()
  if not player then return end
  local pos = player:getPosition()
  if not pos then return end
  
  local opcode_name = 'map_default'  
  
  for _, TABLE in ipairs(SHADERS) do
      if isInPos(pos, TABLE.fromPos, TABLE.toPos) then
         opcode_name = TABLE.opcode_name
      end
  end
  if lastShader and lastShader == opcode_name then return true end
  
  lastShader = opcode_name
  modules.game_interface.gameMapPanel:setShader(opcode_name)
  toggleShaderEvent = scheduleEvent(startShader, 1000)
end      




function isInPos(pos, fromPos, toPos)
	return
		pos.x>=fromPos.x and
		pos.y>=fromPos.y and
		pos.z>=fromPos.z and
		pos.x<=toPos.x and
		pos.y<=toPos.y and
		pos.z<=toPos.z
end