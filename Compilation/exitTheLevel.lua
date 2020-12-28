---------------------------------------------------------------------------------
--
-- exitLevel.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()



-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	-- completely remove maingame and options
	storyboard.removeScene( "level1" )
	storyboard.removeScene( "level2" )
	storyboard.removeScene( "level3" )
	storyboard.removeAll() 
	print( "\nexit Exit the Scene: createScene event" )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local screenGroup = self.view
	
	print( "exit levels: enterScene event" )	
	
	local screenGroup = self.view
	
function exitThisScene()
storyboard.gotoScene( "levels" )
end
	
	
	
timer.performWithDelay(2000, exitThisScene, 1) 


end



-- Called when scene is about to move offscreen:
function scene:exitScene()


	print( "\scene: exit Scene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	
	print( "((\ndestroying exit scene's view))" )
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



