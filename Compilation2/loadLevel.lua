---------------------------------------------------------------------------------
--
-- loadLevel.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	-- completely remove maingame and options
	storyboard.removeScene( "levels" )
	storyboard.removeAll() 
	print( "\noptions: createScene event" )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local screenGroup = self.view
	
	print( "tutorial: enterScene event" )	
	
	local screenGroup = self.view
	

storyboard.gotoScene( "level1" )


end



-- Called when scene is about to move offscreen:
function scene:exitScene()

	--if btnAnim then transition.cancel( btnAnim ); end
	--io.close( fh )
	print( "options: exitScene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	
	print( "((destroying tutorial's view))" )
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



