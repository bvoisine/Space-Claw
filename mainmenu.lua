---------------------------------------------------------------------------------
--
-- mainmenu.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local ui = require("ui")

local path = system.pathForFile( "data.txt", system.TemporaryDirectory )
local fh, reason = io.open( path, "r" )

_G.music = "true"
_G.soundfx = "true"

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	-- completely remove maingame and options
	storyboard.removeScene( "levels" )
	storyboard.removeScene( "options" )
	storyboard.removeScene( "tutorial" )
	
	print( "\nmainmenu: createScene event" )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local screenGroup = self.view
	local gameSettings = {}

	
	print( "mainmenu: enterScene event" )
	
	if fh then
		-- read all contents of file into a string
		local contents = fh:read( "*a" )
		print( "Contents of " .. path .. "\n" .. contents )
		--music = "true"
		--soundfx = "true"
		--fh = io.open( path, "w" )
		--fh:write( tostring(music), ",", tostring(soundfx) )
			local k = 1
			local j = string.len(contents)
		while j > 0 do
        i = string.find(contents,",")
			if i~= nil then
                gameSettings[#gameSettings + 1] = string.sub(contents,k,i-1)
                print(gameSettings[#gameSettings])
                contents = string.sub(contents,i+1,j)
                j = string.len(contents)
			else
                gameSettings[#gameSettings + 1] = string.sub(contents,k,j)
                print(gameSettings[#gameSettings])
                j = 0
			end
		end	
	else
		print( "Reason open failed: " .. reason )  -- display failure message in terminal
		-- create file because it doesn't exist yet
		fh = io.open( path, "w" )
		
		if fh then
			print( "Created file" )
		else
			print( "Create file failed!" )
		end
   
		--local gameSettings = { music,soundfx}
		fh:write( tostring(music), ",", tostring(soundfx) )
	end
	
	print(settings)


	local backgroundMusic = audio.loadStream("Theme.mp3")
	
	if gameSettings[1] == "true" then
	backgroundMusicChannel = audio.play (backgroundMusic, {channel=1, loops=-1, fadein=5000 })
	print "playing music"
	end
	
	local screenGroup = self.view
	
	local btnAnim
	local playBtn
	local optBtn
	local tutBtn	

	local BG = display.newImage("Background.png")
	screenGroup:insert( BG )
	local Menu = display.newImage("Menu.png")
	screenGroup:insert( Menu )

	local onPlayTouch = function( event )
		if event.phase == "release" then
			storyboard.gotoScene( "loadgame", "fade", 300  )
		end
	end
	
	playBtn = ui.newButton{
		defaultSrc = "playbtn.png",
		defaultX = 110,
		defaultY = 50,
		onEvent = onPlayTouch,
		id = "PlayButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	print "hello around PLAY"
	
	playBtn.x = 70; playBtn.y = -200
  	screenGroup:insert( playBtn )
	
	btnAnim = transition.to( playBtn, { time=500, y=190, transition=easing.inOutExpo } )
	
	

	local onOptionsTouch = function( event )
		if event.phase == "release" then
			storyboard.gotoScene( "options", "crossFade", 300  )
		end
	end
	
	optBtn = ui.newButton{
		defaultSrc = "OptionsBtn.png",
		defaultX = 80,
		defaultY = 50,
		onEvent = onOptionsTouch,
		id = "OptionsButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	optBtn.x = 70; optBtn.y = 400
  	screenGroup:insert( optBtn )
	
	btnAnim = transition.to( optBtn, { time=500, y=230, transition=easing.inOutExpo } )
	
	local onTutTouch = function( event )
		if event.phase == "release" then
			storyboard.gotoScene( "tutorial", "crossFade", 300  )
		end
	end
	
	tutBtn = ui.newButton{
		defaultSrc = "TutorialBtn.png",
		defaultX = 80,
		defaultY = 50,
		onEvent = onTutTouch,
		id = "TutorialButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	tutBtn.x = 70; tutBtn.y = 400
  	screenGroup:insert( tutBtn )
	
	btnAnim = transition.to( tutBtn, { time=500, y=260, transition=easing.inOutExpo } )
		
end



-- Called when scene is about to move offscreen:
function scene:exitScene()

	--if btnAnim then transition.cancel( btnAnim ); end
	
	print( "mainmenu: exitScene event" )
	--io.close( fh )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying mainmenu's view))" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene
