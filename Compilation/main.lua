display.setStatusBar( display.HiddenStatusBar )

local licensing = require( "licensing" )
licensing.init( "google" )

local function licensingListener( event )

   local verified = event.isVerified
   if not event.isVerified then
      --failed verify app from the play store, we print a message
      print( "Pirates: Walk the Plank!!!" )
      native.requestExit()  --assuming this is how we handle pirates
   end
end

licensing.verify( licensingListener )

-- require controller module
local storyboard = require ( "storyboard" )

-- load first screen
storyboard.gotoScene( "loadmainmenu" )
