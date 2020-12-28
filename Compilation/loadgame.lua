---------------------------------------------------------------------------------
--
-- loadgame.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local path = system.pathForFile( "data.txt", system.TemporaryDirectory )
local fh, reason = io.open( path, "r" )

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	-- completely remove maingame and options
	storyboard.removeScene( "mainmenu" )
	
	print( "\nload game: createScene event" )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local screenGroup = self.view
	
	print( "tutorial: enterScene event" )	
	
	local screenGroup = self.view
	

	local gameSettings = {}
	
	local BG = display.newImage("tutorial.png")

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
	
	
	print (gameSettings[1], "before all")
	
	function screenTouched(event)
		
			storyboard.gotoScene( "mainmenu", "fade", 300  )
				Runtime:removeEventListener("touch", screenTouched)
		
	end
		Runtime:addEventListener("touch", screenTouched)


end



-- Called when scene is about to move offscreen:
function scene:exitScene()

	--if btnAnim then transition.cancel( btnAnim ); end
	--io.close( fh )
	print( "loadgame: exitScene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	

	print( "((destroying loadgame's view))" )
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



