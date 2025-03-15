-- CONFIG
APP_NAME = "Nto Battle"  -- important, change it, it's name for config dir and files in appdata
APP_VERSION = 1.0      -- client version for updater and login to identify outdated client
DEFAULT_LAYOUT = "CLASSIC" -- on android it's forced to "mobile", check code bellow

-- If you don't use updater or other service, set it to updater = ""
Services = {
 website = "http://ntobattle.com.br",
 updater = "http://ntobattle.com.br/api/updater_advanced.php",
 stats = "",
 crash = "",
 feedback = "",
 status = ""
}

-- Servers accept http login url, websocket login url or ip:port:version
Servers = {
  gold = "127.0.0.1:7171:860",
}
--USE_NEW_ENERGAME = true -- uses entergamev2 based on websockets instead of entergame
ALLOW_CUSTOM_SERVERS = false -- if true it shows option ANOTHER on server list

g_app.setName("Nto Battle")
-- CONFIG END

-- print first terminal message
g_logger.info(g_app.getName() .. ' ' .. g_app.getVersion() .. ' rev ' .. g_app.getBuildRevision() .. ' (' .. g_app.getBuildCommit() .. ') made by ' .. g_app.getAuthor() .. ' built on ' .. g_app.getBuildDate() .. ' for arch ' .. g_app.getBuildArch())
g_logger.info(os.date("== application started at %b %d %Y %X"))

if not g_resources.directoryExists("/data") then
  g_logger.fatal("Data dir doesn't exist.")
end

if not g_resources.directoryExists("/modules") then
  g_logger.fatal("Modules dir doesn't exist.")
end

-- settings
g_configs.loadSettings("/config.otml")

-- set layout
local settings = g_configs.getSettings()
local layout = DEFAULT_LAYOUT
if g_app.isMobile() then
  layout = "mobile"
elseif settings:exists('layout') then
  layout = settings:getValue('layout')
end
g_resources.setLayout(layout)

-- load mods
g_modules.discoverModules()
g_modules.ensureModuleLoaded("corelib")
  
local function loadModules()
  -- libraries modules 0-99
  g_modules.autoLoadModules(99)
  g_modules.ensureModuleLoaded("gamelib")

  -- client modules 100-499
  g_modules.autoLoadModules(499)
  g_modules.ensureModuleLoaded("client")

  -- game modules 500-999
  g_modules.autoLoadModules(999)
  g_modules.ensureModuleLoaded("game_interface")

  -- mods 1000-9999
  g_modules.autoLoadModules(9999)
end

-- report crash
if type(Services.crash) == 'string' and Services.crash:len() > 4 and g_modules.getModule("crash_reporter") then
  g_modules.ensureModuleLoaded("crash_reporter")
end

-- run updater, must use data.zip
if type(Services.updater) == 'string' and Services.updater:len() > 4 
  and g_resources.isLoadedFromArchive() and g_modules.getModule("updater") then
  g_modules.ensureModuleLoaded("updater")
  return Updater.init(loadModules)
end

local oldGameAttack = g_game.attack
g_game.attack = function(target)
    if not target or not g_game.getLocalPlayer() then return end
    if not g_game.canPerformGameAction() or target:getId() == g_game.getLocalPlayer():getId() then return end
    if g_game.getFollowingCreature() and g_game.getFollowingCreature():getId() == target:getId() then g_game.cancelFollow() end
    if g_game.getAttackingCreature() and g_game.getAttackingCreature():getId() == target:getId() then
        g_game.cancelAttack()
        local message = OutputMessage.create()
        message:addU8(0xBE)
        message:addU32(target:getId())
        local protocol = g_game.getProtocolGame()
        protocol:send(message)
    else
        oldGameAttack(target)
        local message = OutputMessage.create()
        message:addU8(0xF5)
        message:addU32(target:getId())
        local protocol = g_game.getProtocolGame()
        protocol:send(message)
    end
end

loadModules()
