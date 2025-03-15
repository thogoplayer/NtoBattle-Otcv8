-- main UI.Separator()


 UI.Separator()


 local loadPanelName = "NtoBattle"
  local ui = setupUI([[
Panel

  height: 20

  Label
    id: editNtoBattle
    color: pink
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 20
    !text: tr('              Discord: NtoBattle')
  ]], parent)



ui.editNtoBattle.onClick = function(widget)
end

 local loadPanelName = "Discord"
  local ui = setupUI([[
Panel

  height: 20

  Button
    id: editDiscord
    color: red
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 20
    text: - Discord  -
    tooltip: Grupo no discord


  ]], parent)

ui.editDiscord.onClick = function(widget)
g_platform.openUrl("https://discord.gg/hzHjrztct9")
end 

 local loadPanelName = "Discord"
  local ui = setupUI([[
Panel

  height: 20

  Button
    id: editDiscord2
    color: red
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 20
    text: - Discord do NTO  -
    tooltip: Grupo no discord


  ]], parent)
  


ui.editDiscord2.onClick = function(widget)
g_platform.openUrl("https://discord.gg/hzHjrztct9")
end 

UI.Separator()

UI.Separator()

UI.Separator()







