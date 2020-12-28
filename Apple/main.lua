display.setStatusBar( display.HiddenStatusBar )

--[[local licensing = require "licensing"
licensing.init( "google" )

local function licensingListener( event )
    local verified = event.isVerified
    if not event.isVerified then
        -- Failed verify app from the play store, we print a message
        print("Pirates!!!")
    end
end

licensing.verify( licensingListener )]]--

-- require controller module
local storyboard = require ( "storyboard" )

-- load first screen
storyboard.gotoScene( "loadmainmenu" )
