---------------------------------------------------------------------------------
--
-- levels.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


local path = system.pathForFile( "data.txt", system.TemporaryDirectory )
local path2 = system.pathForFile( "levels.txt", system.DocumentsDirectory )
local fh, reason = io.open( path, "r" )
local fh2, reason2 = io.open( path2, "r" )
gameSettings2 = {}

-- Called when the scene's view does not exist:
function scene:createScene( event )

	local screenGroup = self.view
	-- completely remove maingame and options
	storyboard.removeScene( "mainmenu" )
	storyboard.removeScene( "level1" )
	storyboard.removeScene( "level2" )
	storyboard.removeScene( "level3" )
	storyboard.purgeScene(storyboard.getPrevious())
	storyboard.removeAll()
	
	print( "\nlevels: createScene event" )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local gameSettings = {}
	
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
                contents = string.sub(contents,i+1,j)
                j = string.len(contents)
			else
                gameSettings[#gameSettings + 1] = string.sub(contents,k,j)
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
	
	if fh2 then
		-- read all contents of file into a string
		--io.open( fh2, "w" )
		local contents2 = fh2:read( "*a" )
		print( "Contents of " .. path2 .. "\n" .. contents2 )
		
		local k = 1
		local j = string.len(contents2)
		
		while j > 0 do
        i = string.find(contents2,",")
			if i~= nil then
                gameSettings2[#gameSettings2 + 1] = string.sub(contents2,k,i-1)
                contents2 = string.sub(contents2,i+1,j)
                j = string.len(contents2)
			else
                gameSettings2[#gameSettings2 + 1] = string.sub(contents2,k,j)
                j = 0
			end
		end	
		--fh:write( gameSettings[1], ",", gameSettings[2] )
	else
		print( "Reason open failed: " .. reason2 )  -- display failure message in terminal
		-- create file because it doesn't exist yet
		fh2 = io.open( path2, "w" )
		
		if fh2 then
			print( "Created file" )
		else
			print( "Create file failed!" )
		end
		local levelTemp = 0
		local scoreTemp = 0
   		gameSettings2 = {levelTemp,scoreTemp}
		print ("game settings 2a: ", gameSettings2[1])
		print ("game settings 2b: ", gameSettings2[2])
		fh2:write( gameSettings2[1], ",", gameSettings2[2] )
	end
	
	print( "levels: enterScene event" )	
	
	local screenGroup = self.view
	
	
	local BG = display.newImage("Mission.png")
	
	local Level1
    local Level2
	local Level3
	local backBtn
	lock = {}
	
	textMessage = display.newText("Select Level to Begin...", 170, 25, 300, 400, "Helvetica", 12 )
	textMessage:setTextColor( 255, 255, 0 )
	
	--[[textMessage2 = display.newText("More Levels Coming Soon!!!", 160, 285, 300, 400, "Helvetica", 12 )
	textMessage2:setTextColor( 255, 255, 255 )]]--
	
	

	local mission1 =
	{
	effect = "fade",
	time = 300,
	params =
	{
	var1 = 1,
	}
	}
	
	local mission2 =
		{
	effect = "fade",
	time = 300,
	params =
	{
	var1 = 2,
	}
	}
	
	
	local mission3 =
		{
	effect = "fade",
	time = 300,
	params =
	{
	var1 = 3,
	}
	}
	
	local onBackTouch = function( event )
		if event.phase == "release" then
			storyboard.gotoScene( "mainmenu", "fade", 300  )
			print "back button"
		end
	end
	
	local onLevel1Touch = function( event )
		if event.phase == "release" then	
			storyboard.gotoScene( "levelload", mission1  )
			print "Level button"
		end
	end	

	local onLevel2Touch = function( event )
		if event.phase == "release" then	
			storyboard.gotoScene( "levelload", mission2  )
			print "Level button"
		end
	end	
	
	local onLevel3Touch = function( event )
		if event.phase == "release" then	
			storyboard.gotoScene( "levelload", mission3  )
			print "Level button"
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
	
	Level1 = ui.newButton{
		defaultSrc = "Level1.png",
		defaultX = 75,
		defaultY = 75,
		onEvent = onLevel1Touch,
		id = "Level1",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	Level2 = ui.newButton{
		defaultSrc = "Level2.png",
		defaultX = 75,
		defaultY = 75,
		onEvent = onLevel2Touch,
		id = "Level1",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	Level3 = ui.newButton{
		defaultSrc = "Level3.png",
		defaultX = 75,
		defaultY = 75,
		onEvent = onLevel3Touch,
		id = "Level3",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}

	for n = 1,6 do
	lock[n] = display.newImage("Lock.png")
	--screenGroup:insert( lock[n] )
	lock[n]:scale( 0.5, 0.5 )
	lock[n].x = 760
	lock[n].y = 115
	end
	

		

	
	--print ("compare these!!!: ", gameSettings2[1])
	if (tonumber(gameSettings2[1]) >= 1) then
	Level2.x = 300; Level2.y = 115
	--print "yo!!!!!!!!!!"
	else
	lock[1].x = 300; lock[1].y = 115
	print ("lock 1 x: ", lock[1].x)
	print ("lock 1 y: ", lock[1].y)
	Level2.x = 760
	--print "show lock!!!!!!"
	end
	
	--print ("compare these!!!: ", gameSettings2[1])
	if (tonumber(gameSettings2[1]) >= 2) then
	Level3.x = 225; Level3.y = 220
	textMessage2 = display.newText("More Levels Coming Soon!!!", 160, 285, 300, 400, "Helvetica", 12 )
	textMessage2:setTextColor( 255, 255, 255 )
	else
	lock[2].x = 225; lock[2].y = 220
	print ("lock 2 x: ", lock[2].x)
	print ("lock 2 y: ", lock[2].y)
	Level3.x = 760
	--print "show lock!!!!!!"
	end
	
	
	--[[lock[4].x = 100; lock[4].y = 220
	lock[5].x = 200; lock[5].y = 220
	lock[6].x = 300; lock[6].y = 220
	lock[7].x = 400; lock[7].y = 220]]--

	Level1.x = 150; Level1.y = 115
	--Level2.x = 300; Level2.y = 115
	--Level3.x = 150; Level3.y = 220
	--lock.x = 300; lock.y = 220

	backBtn.x = 65; backBtn.y = 300

	screenGroup:insert( BG )
	screenGroup:insert( backBtn )
	screenGroup:insert( Level1 )
	screenGroup:insert( Level2 )
	screenGroup:insert( Level3 )
	screenGroup:insert( textMessage )
	if (textMessage2 ~= nil) then
	screenGroup:insert( textMessage2 )	
	end
	for q = 1, #lock do
	screenGroup:insert( lock[q] )
	end
	
	
	
end



-- Called when scene is about to move offscreen:
function scene:exitScene()

	--if btnAnim then transition.cancel( btnAnim ); end
	--[[for z = 1, #lock do
	lock[z]:removeSelf()
	lock[z] = nil
	end]]--
	--io.close( fh2 )
	if (textMessage2 ~= nil) then
		textMessage2:removeSelf()
		textMessage2 = nil
	end
	print( "levels: exitScene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )

	
	print( "((destroying level's view))" )
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



