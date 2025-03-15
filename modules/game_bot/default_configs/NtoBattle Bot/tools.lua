-- tools tab
setDefaultTab("Tools")




comboss = macro(200, "Combo",  function()
if g_game.isAttacking() then
say(storage.ComboText)
say(storage.Combo1Text)
say(storage.Combo2Text)
say(storage.Combo3Text)
say(storage.Combo4Text)
say(storage.Combo5Text)
end

end)
addTextEdit("ComboText", storage.ComboText or "magia 1", function(widget, text) 
storage.ComboText = text
end)
addTextEdit("Combo1Text", storage.Combo1Text or "magia 2", function(widget, text) storage.Combo1Text = text
end)
addTextEdit("Combo2Text", storage.Combo2Text or "magia 3", function(widget, text) storage.Combo2Text = text
end)
addTextEdit("Combo3Text", storage.Combo3Text or "magia 4", function(widget, text) storage.Combo3Text = text
end)
addTextEdit("Combo4Text", storage.Combo4Text or "magia 5", function(widget, text) storage.Combo4Text = text
end)
addTextEdit("Combo5Text", storage.Combo5Text or "magia 6", function(widget, text) storage.Combo5Text = text
end)



addIcon("Combo", {outfit={mount=849,feet=10,legs=10,body=178,type=15,auxType=0,addons=3,head=48}, text="Combo"},comboss)






















senses= macro(500, "Sense Target", "shift+f", function()
if sense then 
say('sense "' .. sense )
end
end)



addIcon("Sense", {outfit={mount=849,feet=10,legs=10,body=178,type=75,auxType=0,addons=3,head=48}, text="Sense"},senses)


macro(1, function() if g_game.isAttacking() and g_game.getAttackingCreature():isPlayer() then sense = g_game.getAttackingCreature():getName() end end)





UI.Separator()


-- allows to test/edit bot lua scripts ingame, you can have multiple scripts like this, just change storage.ingame_lua
UI.Button("Hotkeys", function(newText)
  UI.MultilineEditorWindow(storage.ingame_hotkeys or "", {title="Hotkeys editor", description="You can add your custom hotkeys/singlehotkeys here"}, function(text)
    storage.ingame_hotkeys = text
    reload()
  end)
end)

UI.Separator()

for _, scripts in pairs({storage.ingame_hotkeys}) do
  if type(scripts) == "string" and scripts:len() > 3 then
    local status, result = pcall(function()
      assert(load(scripts, "ingame_editor"))()
    end)
    if not status then 
      error("Ingame edior error:\n" .. result)
    end
  end
end



