-- private variables
local background
local clientVersionLabel

-- public functions
function init()
  background = g_ui.displayUI('background')
  background:lower()
  

  clientVersionLabel = background:getChildById('clientVersionLabel')
  clientVersionLabel:setText("www.ntobattle.com.br")

  if not g_game.isOnline() then
    addEvent(function() g_effects.fadeIn(clientVersionLabel, 1500) end)
    addEvent(function() g_effects.fadeIn(background, 1500) end)
  end

  slide1()

  connect(g_game, { onGameStart = hide })
  connect(g_game, { onGameEnd = show })
end

function terminate()
  disconnect(g_game, { onGameStart = hide })
  disconnect(g_game, { onGameEnd = show })

  g_effects.cancelFade(background:getChildById('clientVersionLabel'))
  background:destroy()

  Background = nil
end

function hide()
  background:hide()
  local name = g_game.getCharacterName()
  g_window.setTitle("Nto Battle | Jogador: "..name)
  

  removeEvent(myLoopEventId1)
  removeEvent(myLoopEventId2)
  removeEvent(myLoopEventId3)
  removeEvent(myLoopEventId4)

end

function show()
  background:show()
end

function hideVersionLabel()
  background:getChildById('clientVersionLabel'):hide()
end

function setVersionText(text)
  clientVersionLabel:setText(text)
end

function ShowBlackWindow()
background:getChildById("blackWindow"):setVisible(true)
background:getChildById("logoAccount"):setVisible(true)
end
function HideBlackWindow()
background:getChildById("blackWindow"):setVisible(false)
background:getChildById("logoAccount"):setVisible(false)
end

function CloseInfos()
background:getChildById("BckgroundSLIDE"):setVisible(false)
background:getChildById("TitleLog"):setVisible(false)
background:getChildById("ImageSLIDE"):setVisible(false)
background:getChildById("TextSLIDE"):setVisible(false)
background:getChildById("BallSelect1"):setVisible(false)
background:getChildById("BallSelect2"):setVisible(false)
background:getChildById("BallSelect3"):setVisible(false)
background:getChildById("BallSelect4"):setVisible(false)
background:getChildById("BckgroundLOG"):setVisible(false)
background:getChildById("Facebook"):setVisible(false)
background:getChildById("Youtube"):setVisible(false)
background:getChildById("Instagram"):setVisible(false)
background:getChildById("Discord"):setVisible(false)
removeEvent(myLoopEventId1)
removeEvent(myLoopEventId2)
removeEvent(myLoopEventId3)
removeEvent(myLoopEventId4)
end
function OpenInfos()
background:getChildById("BckgroundSLIDE"):setVisible(true)
background:getChildById("ImageSLIDE"):setVisible(true)
background:getChildById("TextSLIDE"):setVisible(true)
background:getChildById("BallSelect1"):setVisible(true)
background:getChildById("BallSelect2"):setVisible(true)
background:getChildById("BallSelect3"):setVisible(true)
background:getChildById("BallSelect4"):setVisible(true)
background:getChildById("BckgroundLOG"):setVisible(true)
background:getChildById("Facebook"):setVisible(true)
background:getChildById("Youtube"):setVisible(true)
background:getChildById("Instagram"):setVisible(true)
background:getChildById("Discord"):setVisible(true)
background:getChildById("TitleLog"):setVisible(true)
end


--- looping event slidebar <> LISTA 1
function slide1()
scheduleEvent(function() background:getChildById("ImageSLIDE"):setImageSource('images/slide/image_1')end, 100)
scheduleEvent(function() background:getChildById("TextSLIDE"):setImageSource('images/slide/text_1')end, 100)
scheduleEvent(function() background:getChildById("BallSelect1"):setImageSource('images/slide/ball_white')end, 100) -- Bola 1

scheduleEvent(function() background:getChildById("BallSelect3"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4
scheduleEvent(function() background:getChildById("BallSelect2"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4
scheduleEvent(function() background:getChildById("BallSelect4"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4

removeEvent(myLoopEventId3)
removeEvent(myLoopEventId2)
removeEvent(myLoopEventId4)
myLoopEventId1 = scheduleEvent(slide2, 5000)
end
function slide2()
scheduleEvent(function() background:getChildById("ImageSLIDE"):setImageSource('images/slide/image_2')end, 100)
scheduleEvent(function() background:getChildById("TextSLIDE"):setImageSource('images/slide/text_2')end, 100)
scheduleEvent(function() background:getChildById("BallSelect2"):setImageSource('images/slide/ball_white')end, 100) -- Bola 1

scheduleEvent(function() background:getChildById("BallSelect1"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4
scheduleEvent(function() background:getChildById("BallSelect3"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4
scheduleEvent(function() background:getChildById("BallSelect4"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4

removeEvent(myLoopEventId1)
removeEvent(myLoopEventId3)
removeEvent(myLoopEventId4)

myLoopEventId2 = scheduleEvent(slide3, 5000)
end
function slide3()
scheduleEvent(function() background:getChildById("ImageSLIDE"):setImageSource('images/slide/image_3')end, 100)
scheduleEvent(function() background:getChildById("TextSLIDE"):setImageSource('images/slide/text_3')end, 100)
scheduleEvent(function() background:getChildById("BallSelect3"):setImageSource('images/slide/ball_white')end, 100) -- Bola 1

scheduleEvent(function() background:getChildById("BallSelect1"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4
scheduleEvent(function() background:getChildById("BallSelect2"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4
scheduleEvent(function() background:getChildById("BallSelect4"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4
removeEvent(myLoopEventId1)
removeEvent(myLoopEventId2)
removeEvent(myLoopEventId4)

myLoopEventId3 = scheduleEvent(slide4, 5000)
end
function slide4()
scheduleEvent(function() background:getChildById("ImageSLIDE"):setImageSource('images/slide/image_4')end, 100)
scheduleEvent(function() background:getChildById("TextSLIDE"):setImageSource('images/slide/text_4')end, 100)
scheduleEvent(function() background:getChildById("BallSelect4"):setImageSource('images/slide/ball_white')end, 100) -- Bola 1

scheduleEvent(function() background:getChildById("BallSelect1"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4
scheduleEvent(function() background:getChildById("BallSelect2"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4
scheduleEvent(function() background:getChildById("BallSelect3"):setImageSource('images/slide/ball_transparent')end, 100) -- Bola 4

removeEvent(myLoopEventId1)
removeEvent(myLoopEventId2)
removeEvent(myLoopEventId3)

myLoopEventId4 = scheduleEvent(slide1, 5000)
end
--- looping event slidebar <> LISTA 1

