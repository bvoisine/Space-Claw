---------------------------------------------------------------------------------
--
-- levelload.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


local path = system.pathForFile( "data.txt", system.TemporaryDirectory )
local fh, reason = io.open( path, "r" )

catDieSound = audio.loadSound("catdie.mp3")

-- Called when the scene's view does not exist:
function scene:createScene( event )

	local screenGroup = self.view
	-- completely remove maingame and options
	storyboard.removeScene( "mainmenu" )
	storyboard.removeScene( "levels" )
	storyboard.purgeScene(storyboard.getPrevious())
	storyboard.removeAll()
	
	print( "\nlevel loader: createScene event" )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )

	
	print( "loadlevel1: enterScene event" )	
	
	local screenGroup = self.view
	local params = event.params

	local gameSettings = {}
	
	local BG = display.newImage("Mission.png")

	screenGroup:insert( BG )
	
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
	
	
	if (params.var1 == 1) then
	
	textMessage = display.newText( "Mission 1:  Suburbia A\nDate:  2013\nLocation:  Earth\n\nAn evil alien race has infested the galaxy throughout multiple time periods. You must hunt down the aliens and dispose of them.\n \nYour first mission will take place within a suburban neighborhood on Earth in the year 2013.", 25, 25, 300, 400, "Helvetica", 14 )
	textMessage:setTextColor( 255, 0, 0 )
	textMessage2 = display.newText("Touch Screen to Begin Mission...", 140, 285, 300, 400, "Helvetica", 12 )
	textMessage2:setTextColor( 255, 255, 0 )
	levelGoto = "level1"
	local mission =
	{
	effect = "fade",
	time = 300,
	params =
	{
	var1 = 1,
	}
	}
	elseif (params.var1 == 2) then
	
	textMessage = display.newText( "Mission 2:  Galaxy V \nDate:  4591\nLocation:  Galaxy V\n\nThe aliens are now taking over Galaxy V. Go to Galaxy V and remove the aliens.\n\nWatch out for the energy charged beams and \n the evil alien bunnies.", 25, 25, 300, 400, "Helvetica", 14 )
	textMessage:setTextColor( 255, 0, 0 )
	textMessage2 = display.newText("Touch Screen to Begin Mission...", 140, 285, 300, 400, "Helvetica", 12 )
	textMessage2:setTextColor( 255, 255, 0 )
	levelGoto = "level2"
	local mission =
	{
	effect = "fade",
	time = 300,
	params =
	{
	var1 = 2,
	}
	}
	
	else
	
	textMessage = display.newText( "Mission 3:  The Jungle \nDate:  300 BC \nLocation:  Earth - Amazon Rainforest\n\nFly through the rainforest to dispose of the aliens during this time period of Earth.\n\nWatch out for the fire-lit thorn beams and\n the evil alien frogs.", 25, 25, 300, 400, "Helvetica", 14 )
	textMessage:setTextColor( 255, 0, 0 )
	textMessage2 = display.newText("Touch Screen to Begin Mission...", 140, 285, 300, 400, "Helvetica", 12 )
	textMessage2:setTextColor( 255, 255, 0 )
	levelGoto = "level3"
	local mission =
	{
	effect = "fade",
	time = 300,
	params =
	{
	var1 = 3,
	}
	}	
	
	end
	
	
	print (gameSettings[1], "before all")
	
	function screenTouched(event)
			Runtime:removeEventListener("touch", screenTouched)		
			storyboard.gotoScene( tostring(levelGoto), mission )
	end
		Runtime:addEventListener("touch", screenTouched)


end



-- Called when scene is about to move offscreen:
function scene:exitScene()

	--if btnAnim then transition.cancel( btnAnim ); end
	--io.close( fh )
	print( "leveload: exitScene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	--group:remove( screenGroup )
	textMessage:removeSelf()
	textMessage = nil
	textMessage2:removeSelf()
	textMessage2 = nil
	print( "((destroying levelload's view))" )
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



