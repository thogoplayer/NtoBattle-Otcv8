onKeyPress(function(keys) 
 if (bmpw.isOn()) and not isInPz() then
 consoleModule = modules.game_console
  if (keys == bugn and not consoleModule:isChatEnabled()) then
   ppos = pos()
   ppos.y = ppos.y - 6
   bgTile = g_map.getTile(ppos)
   if bgTile then
    use(g_map.getTile(ppos):getTopUseThing())
   end
  elseif (keys == bugs and not consoleModule:isChatEnabled()) then
   ppos = pos()
   ppos.y = ppos.y + 7
   bgTile = g_map.getTile(ppos)
   if bgTile then
    use(g_map.getTile(ppos):getTopUseThing())
   end
  elseif (keys == buge and not consoleModule:isChatEnabled()) then
   ppos = pos()
   ppos.x = ppos.x - 7
   bgTile = g_map.getTile(ppos)
   if bgTile then
    use(g_map.getTile(ppos):getTopUseThing())
   end
  elseif (keys == bugd and not consoleModule:isChatEnabled()) then
   ppos = pos()
   ppos.x = ppos.x + 7
   bgTile = g_map.getTile(ppos)
   if bgTile then
    use(g_map.getTile(ppos):getTopUseThing())
   end
  end
 end
end)
   
   


bmpw = macro(1, 'Bug Map', 'shift+a', function()
 if not bugconfig or (bugconfig and bugconfig ~= 'WASD') then
  bugn = 'W'
  bugs = 'S'
  buge = 'A'
  bugd = 'D'
  bugconfig = 'WASD'
 end
end,scpPanel)