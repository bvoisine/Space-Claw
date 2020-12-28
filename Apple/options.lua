---------------------------------------------------------------------------------
--
-- options.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local ui = require("ui")

local path = system.pathForFile( "data.txt", system.TemporaryDirectory )
local fh, reason = io.open( path, "r" )

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	-- completely remove maingame and options
	storyboard.removeScene( "mainmenu" )
	
	print( "\noptions: createScene event" )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local screenGroup = self.view
	
	print( "options: enterScene event" )	
	
	local screenGroup = self.view
	
	local btnAnim
	local musicBtn
	local soundfxBtn
	local backBtn
	local gameSettings = {}
	
	local BG = display.newImage("Background.png")
	screenGroup:insert( BG )
	local Menu = display.newImage("Menu.png")
	screenGroup:insert( Menu )
	local backgroundMusic = audio.loadStream("Theme.mp3")
	
	-------------------------------------------------------------
	-- Check file for entries
	-------------------------------------------------------------
	if fh then
		-- read all contents of file into a string
		local contents = fh:read( "*a" )
		print( "Contents of " .. path .. "\n" .. contents )
		
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
		--fh:write( gameSettings[1], ",", gameSettings[2] )
	else
		print( "Reason open failed: " .. reason )  -- display failure message in terminal
		-- create file because it doesn't exist yet
		fh = io.open( path, "w" )
		
		if fh then
			print( "Created file" )
		else
			print( "Create file failed!" )
		end
   		gameSettings = {music,soundfx}
		fh:write( gameSettings[1], ",", gameSettings[2] )
	end
	
	function playMusicNow()
		backgroundMusicChannel = audio.play (backgroundMusic, {channel=1, loops=-1, fadein=5000 })
		print "playing music"
	end
	
	-------------------------------------------------------------
	-- Event for music on/off
	-------------------------------------------------------------
	local onMusicTouch = function( event )
		if event.phase == "release" then
			
			if (gameSettings[1] == "true") then
				gameSettings[1] = "false"
				music = "false"
				print "music button touched, now 1"
				musicBtn:removeSelf()
				musicBtn = nil
				musicStatus()
				audio.pause( 1 )
			else
				gameSettings[1] = "true"
				music = "true"
				print "music button touched, now 0"
				musicBtn:removeSelf()
				musicBtn = nil
				local tryResume = audio.resume( 1 )
				playMusicNow()
				musicStatus()
				print ( tryResume )
			end
			
		end
	end
	
	print (gameSettings[1], "before all")

	-------------------------------------------------------------
	-- Check for current status of music setting
	-------------------------------------------------------------	
function musicStatus()	
	if (gameSettings[1] == "true") then
	music = "true"
	musicBtn = ui.newButton{
		defaultSrc = "MusicOn.png",
		defaultX = 110,
		defaultY = 50,
		overSrc = "MusicOff.png",
		overX = 110,
		overY = 50,
		onEvent = onMusicTouch,
		id = "MusicButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	print "check me!"
	else
	music = "false"
	musicBtn = ui.newButton{
		defaultSrc = "MusicOff.png",
		defaultX = 110,
		defaultY = 50,
		overSrc = "MusicOn.png",
		overX = 110,
		overY = 50,
		onEvent = onMusicTouch,
		id = "MusicButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	print "other one!"
	end
	
	musicBtn.x = 70; musicBtn.y = 160
  	screenGroup:insert( musicBtn )

end	



-- Check Music Status
musicStatus()

	-------------------------------------------------------------
	-- Event for soundfx on/off
	-------------------------------------------------------------
	
	local onSoundFXTouch = function( event )
		if event.phase == "release" then
			print "sound fx button"
			if (gameSettings[2] == "true") then
				gameSettings[2] = "false"
				soundfx = "false"
				print "soundfx button touched, now 1"
				soundfxBtn:removeSelf()
				soundfxBtn = nil
				soundfxStatus()
				--audio.pause( 1 )
			else
				gameSettings[2] = "true"
				soundfx = "true"
				print "music button touched, now 0"
				soundfxBtn:removeSelf()
				soundfxBtn = nil
				soundfxStatus()
				--local tryResume = audio.resume( 1 )
				--print ( tryResume )
			end
			
		end
	end
	
	-------------------------------------------------------------
	-- Check for current status of sound fx setting
	-------------------------------------------------------------	
function soundfxStatus()	
	if (gameSettings[2] == "true") then
	soundfx = "true"
	soundfxBtn = ui.newButton{
		defaultSrc = "SoundFXOn.png",
		defaultX = 110,
		defaultY = 50,
		overSrc = "SoundFXOff.png",
		overX = 110,
		overY = 50,
		onEvent = onSoundFXTouch,
		id = "SoundFXButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	else
	soundfx = "false"
	soundfxBtn = ui.newButton{
		defaultSrc = "SoundFXOff.png",
		defaultX = 110,
		defaultY = 50,
		overSrc = "SoundFXOn.png",
		overX = 110,
		overY = 50,
		onEvent = onSoundFXTouch,
		id = "MusicButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	end
	
	
	soundfxBtn.x = 70; soundfxBtn.y = 220
  	screenGroup:insert( soundfxBtn )
	
end	


-- Check Soundfx Status
soundfxStatus()
	
	-------------------------
	
	local onBackTouch = function( event )
		if event.phase == "release" then
			storyboard.gotoScene( "mainmenu", "fade", 300  )
			print "back button"
		end
	end
	
	backBtn = ui.newButton{
		defaultSrc = "BackBtn.png",
		defaultX = 80,
		defaultY = 40,
		onEvent = onBackTouch,
		id = "BackButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	print "hello around BACK"
	
	backBtn.x = 50; backBtn.y = -200
  	screenGroup:insert( backBtn )
	
	btnAnim = transition.to( backBtn, { time=500, y=300, transition=easing.inOutExpo } )
		

end



-- Called when scene is about to move offscreen:
function scene:exitScene()

	--if btnAnim then transition.cancel( btnAnim ); end
	fh = io.open( path, "w" )
	fh:write( tostring(music), ",", tostring(soundfx) )
	io.close( fh )
	print( "options: exitScene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying option's view))" )
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





