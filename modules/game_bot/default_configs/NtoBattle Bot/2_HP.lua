 -- config
setDefaultTab("HP")
 



lblInfo= UI.Label("-- [[ ANTI-PARALYZE ]] --")
lblInfo:setColor("green")
addSeparator()
addSeparator() Panels.AntiParalyze() UI.Separator() 

lblInfo= UI.Label("-- [[ SPEED ]] --")
lblInfo:setColor("green")
addSeparator()
addSeparator() Panels.Haste() UI.Separator() 

lblInfo= UI.Label("-- [[ BUFF ]] --")
lblInfo:setColor("green")
addSeparator()
addSeparator()
addTextEdit(" BUFF", storage.buff or "buff magia", function(widget, text)
    storage.buff = text
end)
addTextEdit(" BUFF", storage.buff or "buff magia", function(widget, text)
    storage.buff = text
end)

buffz = macro(1000, "Buff", function()
local buff = storage.buff
  say(buff)
end) UI.Separator()

addIcon("buffz", {outfit={mount=849,feet=10,legs=10,body=178,type=95,auxType=0,addons=3,head=48}, text="Buff"},buffz)

lblInfo= UI.Label("-- [[ TREINO ]] --")
lblInfo:setColor("green")
addSeparator()
addSeparator()
if type(storage.manatrainer) ~= "table" then
  storage.manatrainer = {on=false, title="mana%", text="Treinar Mana", min=0, max=90}
end

for _, healingInfos in ipairs({storage.manatrainer}) do
  local healingmacro = macro(20, function()
    local mana = manapercent()
    if healingInfos.max <= mana and mana >= healingInfos.min then
      if TargetBot then 
        TargetBot.saySpell(healingInfos.text) -- sync spell with targetbot if available
      else
        say(healingInfos.text)
      end
    end
  end)
  healingmacro.setOn(healingInfos.on)

  UI.DualScrollPanel(healingInfos, function(widget, newParams) 
    healingInfos = newParams
    healingmacro.setOn(healingInfos.on)
  end)
end 
healingmacro = macro(20, "Dance", function()
    turn(math.random(0, 3))
end)



