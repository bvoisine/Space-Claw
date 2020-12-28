---------------------------------------------------------------------------------
--
-- loadgame.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local myTimer
local loadingImage

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	-- completely remove mainmenu
	storyboard.removeScene( "mainmenu" )
	
	print( "\nloadgame: createScene event" )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local screenGroup = self.view
	
	print( "loadgame: enterScene event" )
	
	loadingImage = display.newImageRect( "loading.png", 480, 320 )
	loadingImage.x = 240; loadingImage.y = 160
	screenGroup:insert( loadingImage )
	
	local changeScene = function()
		storyboard.gotoScene( "maingame", "flipFadeOutIn", 500 )
	end
	myTimer = timer.performWithDelay( 1000, changeScene, 1 )
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene()

	if myTimer then timer.cancel( myTimer ); end
	
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