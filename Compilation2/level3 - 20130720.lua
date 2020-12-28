---------------------------------------------------------------------------------
--
-- level3.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local Particles	= require("lib_particle_candy")
local ui = require("ui")
local physics = require("physics")
local sheetInfo = require("sprites")
local tnt = require('tnt')
local score = 0
local gameOn = true

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	-- completely remove maingame and options
	storyboard.removeAll()
	storyboard.removeScene( "levels" )
	storyboard.removeScene( "levelload" )
	
	print( "\nlevel 3: createScene event" )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local screenGroup = self.view
	local objectGroup = display.newGroup()
	local backgroundMusic = audio.loadStream("Theme.mp3")
	print( "levels: enterScene event" )	


-- LOAD PARTICLE LIB

local path = system.pathForFile( "data.txt", system.TemporaryDirectory )
local path2 = system.pathForFile( "levels.txt", system.DocumentsDirectory )
local fh, reason = io.open( path, "r" )
local fh2, reason2 = io.open( path2, "r" )

local screenW = display.contentWidth
local screenH = display.contentHeight

local StatusText = display.newText( " ", screenW/2, screenH-20, native.systemFont, 12 )
StatusText:setTextColor( 255,255,255 )
objectGroup:insert( StatusText )

-- CREATE EMITTERS (NAME, SCREENW, SCREENH, ROTATION, ISVISIBLE, LOOP)
Particles.CreateEmitter("E1", screenW*0.05, screenH*0.5, 90, false, true)

-- DEFINE PARTICLE TYPE PROPERTIES
local Properties 			= {}
Properties.imagePath			= "flame.png"
Properties.imageWidth			= 20	-- PARTICLE IMAGE WIDTH  (newImageRect)
Properties.imageHeight			= 20	-- PARTICLE IMAGE HEIGHT (newImageRect)
Properties.velocityStart		= 150	-- PIXELS PER SECOND
Properties.alphaStart			= 0		-- PARTICLE START ALPHA
Properties.fadeInSpeed			= 2.0	-- PER SECOND
Properties.fadeOutSpeed			= -0.5	-- PER SECOND
Properties.fadeOutDelay			= 1000	-- WHEN TO START FADE-OUT
Properties.scaleStart			= 0.5	-- PARTICLE START SIZE
Properties.scaleVariation		= 0.5	-- RANDOMLY ADDED SCALE VARIATION
Properties.scaleInSpeed			= 1.75	-- PARTICLE SCALE-IN SPEED
Properties.rotationVariation		= 360 	-- RANDOM ROTATION
Properties.rotationChange		= 30
Properties.weight			= 0		-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
Properties.bounceX			= false -- REBOUND FROM SCREEN LEFT & RIGHT BORDER
Properties.bounceY			= false -- REBOUND FROM SCREEN TOP & BOTTOM BORDER
Properties.bounciness			= 0.75  -- REBOUND ENERGY
Properties.emissionShape		= 0		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
Properties.emissionRadius		= 140	-- SIZE / RADIUS OF EMISSION SHAPE
Properties.killOutsideScreen		= true	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
Properties.lifeTime				= 4000  -- MAX. LIFETIME OF A PARTICLE
Properties.autoOrientation		= false	-- AUTO-ROTATE INTO MOVEMENT DIRECTION
Properties.useEmitterRotation		= false	--INHERIT EMITTER'S CURRENT ROTATION
Properties.blendMode			= "add" -- SETS BLEND MODE ("add" OR "normal", DEFAULT IS "normal")
Properties.colorChange			= {-50,-100,-125},
Particles.CreateParticleType ("Flame", Properties)

-- DEFINE PARTICLE TYPE PROPERTIES
local Properties 			= {}
Properties.imagePath			= "smoke.png"
Properties.imageWidth			= 20	-- PARTICLE IMAGE WIDTH  (newImageRect)
Properties.imageHeight			= 20	-- PARTICLE IMAGE HEIGHT (newImageRect)
Properties.velocityStart		= 100	-- PIXELS PER SECOND
Properties.velocityVariation		= 50
Properties.alphaStart			= 0		-- PARTICLE START ALPHA
Properties.fadeInSpeed			= 2.0	-- PER SECOND
Properties.fadeOutSpeed			= -0.5	-- PER SECOND
Properties.fadeOutDelay			= 1000	-- WHEN TO START FADE-OUT
Properties.scaleStart			= 0.5	-- PARTICLE START SIZE
Properties.scaleVariation		= 0.5	-- RANDOMLY ADDED SCALE VARIATION
Properties.scaleInSpeed			= 2		-- PARTICLE SCALE-IN SPEED
Properties.rotationVariation		= 360 	-- RANDOM ROTATION
Properties.rotationChange		= 30
Properties.weight			= 0		-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
Properties.bounceX			= false -- REBOUND FROM SCREEN LEFT & RIGHT BORDER
Properties.bounceY			= false -- REBOUND FROM SCREEN TOP & BOTTOM BORDER
Properties.bounciness			= 0.75  -- REBOUND ENERGY
Properties.emissionShape		= 0		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
Properties.emissionRadius		= 140	-- SIZE / RADIUS OF EMISSION SHAPE
Properties.killOutsideScreen		= true	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
Properties.lifeTime			= 4000  -- MAX. LIFETIME OF A PARTICLE
Properties.autoOrientation		= false	-- AUTO-ROTATE INTO MOVEMENT DIRECTION
Properties.useEmitterRotation		= false	--INHERIT EMITTER'S CURRENT ROTATION
Properties.colorChange			= {-100,-125,-155},
Particles.CreateParticleType ("Smoke", Properties)

-- FEED EMITTERS (EMITTER NAME, PARTICLE TYPE NAME, EMISSION RATE, DURATION, DELAY)
Particles.AttachParticleType("E1", "Flame", 7, 9999,0) 
Particles.AttachParticleType("E1", "Smoke", 7, 9999,0) 

local Emitter1 = Particles.GetEmitter("E1")

-- ATTRACTION FIELD
Particles.CreateFXField("F1", 0, screenW*0.5,screenH*0.5, 1.5, 140, false)


--local scaleFactor = .2


physics.start()
physics.setGravity( 0, 0 )
local scaleFactor = 1.0
local physicsData = (require "shapedefs").physicsData(scaleFactor)
local gameSettings = {}
local timerIndex = {}
local buttonGroup
local musicBtn
local soundfxBtn
local soundfx
local music
local maxLevel
local ExitBtn
local deadCat = false
--local catDieSound = audio.loadSound("catdie.mp3")


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
		fh:write( gameSettings[1], ",", gameSettings[2])
	end
	
	
	function playMusicNow()
		backgroundMusicChannel = audio.play (backgroundMusic, {channel=1, loops=-1, fadein=5000 })
		print "playing music"
	end
	-------------------------------------------------------------
	-- Event for music on/off
	-------------------------------------------------------------	
	function onMusicTouch( event )
		if event.phase == "release" then
			
			if (gameSettings[1] == "true") then
				gameSettings[1] = "false"
				music = "false"
				print "music button touched, now 1"
				musicBtn:removeSelf()
				musicBtn = nil
				musicStatus()
				audio.pause( 1 )
				fh = io.open( path, "w" )
				fh:write( tostring(music), ",", tostring(soundfx))
				io.close( fh )
				print("Writing... ", tostring(music), ",", tostring(soundfx)) 
			else
				gameSettings[1] = "true"
				music = "true"
				print "music button touched, now 0"
				musicBtn:removeSelf()
				musicBtn = nil
				musicStatus()
				fh = io.open( path, "w" )
				fh:write( tostring(music), ",", tostring(soundfx))
				io.close( fh )
				print("Writing... ", tostring(music), ",", tostring(soundfx)) 
				local tryResume = audio.resume( 1 )	
				playMusicNow()
				--print ( tryResume )
			end
			
		end
	end
	
	
	function onSoundFXTouch( event )
		if event.phase == "release" then
			print "sound fx button"
			if (gameSettings[2] == "true") then
				gameSettings[2] = "false"
				soundfx = "false"
				print "soundfx button touched, now 1"
				soundfxBtn:removeSelf()
				soundfxBtn = nil
				soundfxStatus()
				fh = io.open( path, "w" )
				fh:write( tostring(music), ",", tostring(soundfx))
				io.close( fh )
				print("Writing... ", tostring(music), ",", tostring(soundfx)) 
				--audio.pause( 1 )
			else
				gameSettings[2] = "true"
				soundfx = "true"
				print "music button touched, now 0"
				soundfxBtn:removeSelf()
				soundfxBtn = nil
				soundfxStatus()
				fh = io.open( path, "w" )
				fh:write( tostring(music), ",", tostring(soundfx))
				io.close( fh )
				print("Writing... ", tostring(music), ",", tostring(soundfx)) 				
				--local tryResume = audio.resume( 1 )
				--print ( tryResume )
			end
			
		end
	end
	

	
	

-- Hide Status Bar on iStuff

display.setStatusBar(display.HiddenStatusBar)
system.activate("multitouch")

-- Variables



local pauseText2
local pauseText
local pauseBtn2
local screenText
local weaponBlast
local jetName
local isAlive = true
local dangerousAlien = true
local dangerousUFO = true
local dangerousLaser = true
local dangerousBeam = true
local dangerousBunny = true
local iter = 0
local gameIsActive = true 
local update
local yAxisLaser
local speed = 5
local warpScore = true




	local myImageSheet = graphics.newImageSheet( "sprites.png", sheetInfo:getSheet() )

-- Larger images
	sky = display.newImage("BlueSky.png")
	sky:setFillColor(170, 0, 255)
	screenGroup:insert( sky )
	

	jungleback = display.newImage("jungleback.png")
	jungleback.x = 0
	screenGroup:insert( jungleback )
	
	jungleback2 = display.newImage("jungleback.png")
	jungleback2.x = 760
	screenGroup:insert( jungleback2 )
	
	jungleback3 = display.newImage("jungleback.png")
	jungleback3.x = 300
	screenGroup:insert( jungleback3 )
	
	
	brush = display.newImage( "junglebrush.png" )
	brush.x = 0
	screenGroup:insert( brush )
	
	brush2 = display.newImage( "junglebrush.png" )
	brush2.x = 300
	screenGroup:insert( brush2 )
	
	brush3 = display.newImage( "junglebrush.png" )
	brush3.x = 400
	screenGroup:insert( brush3 )
	

	Tree = display.newImage( "jungletree1.png" )
	Tree.x = 0
	screenGroup:insert( Tree )
	
	Tree2 = display.newImage( "jungletree2.png" )
	Tree2.x = 300
	screenGroup:insert( Tree2 )
	
	brush4 = display.newImage( "junglebrush.png" )
	brush4.x = 500
	screenGroup:insert( brush4 )

		
	Tree3 = display.newImage( "jungletree2.png" )
	Tree3.x = 300
	screenGroup:insert( Tree3 )
	

	
laser = {}
	
-- Create Laser Beam
for a = 1, 3 do
	laser[a] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("laser"))
	laser[a].x = 760
	laser[a].collision = onLocalCollision
	laser[a].radius = 0.15
	jetCollisionFilter = { categoryBits = 2, maskBits = 9 }
	physics.addBody( laser[a], dynamic, { density=1, friction=0, bounce=15.0, radius=laser.radius, filter=jetCollisionFilter } )
	--jet[a].rotation = 10.0
    --jet[a].name = ("jet" .. a)
	laser[a].name = "laser"
    laser[a].id = (a)
	laser[a].isSensor = true
	screenGroup:insert( laser[a] )
	--print (jet[a].id .. " created")
	--print ("Hello: " .. jet[a].name)
end

local b = 0
local c = 0
local randomBar = 0
beam = {}
local yAxisRandomBeam = 0
yAxisRandomBeam = math.random (20, 180)

	beam[1] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("jbeam"))
	beam[1].x = 760
	beam[1].y = 100
	beam[1].name = "beam"
	physics.addBody( beam[1], dynamic, { density=1, friction=0, bounce=15.0, radius=beam[1].radius, filter=jetCollisionFilter } )
	beam[1].isSensor = true
	screenGroup:insert( beam[1] )
	beam[2] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("jbeam"))
	beam[2].x = 760
	beam[2].y = 0
	physics.addBody( beam[2], dynamic, { density=1, friction=0, bounce=15.0, radius=beam.radius, filter=jetCollisionFilter } )
	beam[2].isSensor = true
	beam[2].name = "beam"
	screenGroup:insert( beam[2] )
	beam[3] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("jbeam"))
	beam[3].x = 760
	beam[3].y = 330
	physics.addBody( beam[3], dynamic, { density=1, friction=0, bounce=15.0, radius=beam.radius, filter=jetCollisionFilter } )
	beam[3].isSensor = true
	beam[3].name = "beam"
	screenGroup:insert( beam[3] )
	beam[4] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("jbeam"))
	beam[4].x = 760
	beam[4].y = 0
	physics.addBody( beam[4], dynamic, { density=1, friction=0, bounce=15.0, radius=beam.radius, filter=jetCollisionFilter } )
	beam[4].isSensor = true
	beam[4].name = "beam"
	screenGroup:insert( beam[4] )
	beam[5] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("jbeam"))
	beam[5].x = 760
	beam[5].y = 330
	physics.addBody( beam[5], dynamic, { density=1, friction=0, bounce=15.0, radius=beam.radius, filter=jetCollisionFilter } )
	beam[5].isSensor = true
	beam[5].name = "beam"
	screenGroup:insert( beam[5] )
	beam[6] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("jbeam"))
	beam[6].x = 1300
	beam[6].y = 200
	physics.addBody( beam[6], dynamic, { density=1, friction=0, bounce=15.0, radius=beam.radius, filter=jetCollisionFilter } )
	beam[6].isSensor = true
	beam[6].name = "beam"
	screenGroup:insert( beam[6] )
	
	for n = 7, 50 do
	randomBar = math.random (1, 4)
	beam[n] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("jbeam", randomBar))
	beam[n].y = 0
	beam[n].x = 760 + b
	b = b + 50
	physics.addBody( beam[n], dynamic, { density=1, friction=0, bounce=15.0, radius=beam.radius, filter=jetCollisionFilter } )
	beam[n].isSensor = true
	beam[n].name = ("beam")
	end
	
	b = 0
	
function createBeamTunnel()	
	for n = 7, 50 do
	randomBar = math.random (1, 4)
	beam[n] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("beam", randomBar))
	beam[n].y = 0
	beam[n].x = 760 + b
	b = b + 50
	physics.addBody( beam[n], dynamic, { density=1, friction=0, bounce=15.0, radius=beam.radius, filter=jetCollisionFilter } )
	beam[n].isSensor = true
	beam[n].name = ("beam")
	end
	
	b = 0
	
	for z = 51, 100 do
	randomBar = math.random (1, 4)
	beam[z] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("beam", randomBar))
	beam[z].y = 330
	beam[z].x = 760 + b
	b = b + 50
	physics.addBody( beam[z], dynamic, { density=1, friction=0, bounce=15.0, radius=beam.radius, filter=jetCollisionFilter } )
	beam[z].isSensor = true
	beam[z].name = ("beam")
	--print ("create beam up: ", beam[z].x)
	end

	for n = 7, #beam do
		if (beam[n] ~= nil) then
		screenGroup:insert( beam[n] )
		end
	end
end


	ufo = display.newImage( myImageSheet , sheetInfo:getFrameIndex("BadShip"))
	ufo.x = 760
	ufo.name = "ufo"
	physics.addBody( ufo, dynamic, { density=1, friction=0, bounce=15.0, radius=ufo.radius, filter=jetCollisionFilter } )
	ufo.isSensor = true
	screenGroup:insert( ufo )

	
	bunny = display.newImage( myImageSheet , sheetInfo:getFrameIndex("bunny"))
	bunny.x = 760
	bunny.name = "bunny"
	physics.addBody( bunny, dynamic, { density=1, friction=0, bounce=15.0, radius=ufo.radius, filter=jetCollisionFilter } )
	bunny.isSensor = true
	screenGroup:insert( bunny )
	
	local endLevelGate = display.newImage( "endLevelGate.png" )
	physics.addBody( endLevelGate, dynamic, { density=1, friction=0, bounce=15.0, radius=endLevelGate.radius, filter=jetCollisionFilter } )
	endLevelGate.isSensor = true
	endLevelGate.name = "endLevelGate"
	endLevelGate.x = 760
	endLevelGate.y = 150
	screenGroup:insert( endLevelGate )
	
	
local sequenceData = {
	name="flying",
    frames = { 13, 14, 15, 16, 15, 14 },
    --count=6,
    time=1000,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
    loopCount = 0    -- Optional. Default is 0 (loop indefinitely)
}

local sequenceData2 = {
	name="weaponBlast",
    frames = { 26, 27, 28, 29, 29, 28, 27 },
    --count=6,
    time=800,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
    loopCount = 2
}


	cat = display.newSprite( myImageSheet, sequenceData )	
	--cat:scale( 0.15, 0.15 )
	cat.x = 80
	cat.y = 100
	cat.name = "cat"
	--cat.collision = onLocalCollision
	--local catCollisionFilter = { categoryBits = 1, maskBits = 6 }
	physics.addBody( cat, dynamic, { density=1, friction=0, bounce=0, shape = { -97, -145  ,  -187, -166  ,  -122, -195 }, filter=jetCollisionFilter } )
	cat.rotation = 0
	cat.isSensor = true
	cat:play()
	screenGroup:insert( cat )
	
	EvilMouse = display.newImage( myImageSheet , sheetInfo:getFrameIndex("EvilMouse"))
	physics.addBody( EvilMouse, dynamic, { density=1, friction=0, bounce=15.0, radius=ufo.radius, filter=jetCollisionFilter } )
	EvilMouse.isSensor = true
	EvilMouse.name = "EvilMouse"
	EvilMouse.x = 760
	EvilMouse.y = 300
	screenGroup:insert( EvilMouse )

local alien = {}
	
-- Create Aliens
for a = 1, 6 do

	alien[a] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("alien"))
	physics.addBody( alien[a], dynamic, { density=1, friction=0, bounce=15.0, radius=alien.radius, shape = {   -19, -306  ,  2, -293  ,  -81, -295  ,  -83, -322  }, filter=jetCollisionFilter } )
	alien[a].isSensor = true
	alien[a].collision = onLocalCollision
	alien[a].name = "alien"
	alien[a].myName = "alien"
	alien[a].id = (a)
	alien[a].x = 760
	alien[a].y = 300
	screenGroup:insert( alien[a] )

end
	

	
	warpGateZing = display.newImage( myImageSheet , sheetInfo:getFrameIndex("warpGateZing"))
	physics.addBody( warpGateZing, dynamic, { density=1, friction=0, bounce=15.0, radius=ufo.radius, filter=jetCollisionFilter } )
	warpGateZing.isSensor = true
	warpGateZing.name = "warpGateZing"
	warpGateZing.x = 760
	warpGateZing.y = 300
	screenGroup:insert( warpGateZing )
	
	Grass = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Grass"))
	Grass.y = 315
	Grass.x = 240
	screenGroup:insert( Grass )
	
	Grass2 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Grass"))
	Grass2.y = 315
	Grass2.x = 240
	screenGroup:insert( Grass2 )
	
	Grass3 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Grass"))
	Grass3.y = 316
	Grass3.x = 760
	screenGroup:insert( Grass3 )
		
	local j = 1	

	
	local pauseBtn = display.newImage( myImageSheet , sheetInfo:getFrameIndex("pauseBtn"))
	pauseBtn.x = 460
	pauseBtn.y = 25
	screenGroup:insert( pauseBtn )

	
	local weaponBtn = display.newImage( myImageSheet , sheetInfo:getFrameIndex("specialBtn"))
	weaponBtn.x = 440
	weaponBtn.y = 280
	weaponBtn:scale(.75, .75)
	screenGroup:insert( weaponBtn )
	--[[
	local warpGate = display.newImage( myImageSheet, sequenceData3 )
	warpGate:play()
	--warpGate:play()
	warpGate.x = 200
	warpGate.y = 160
	--warpGate:scale(.5, .5)]]--
	
	
	--[[local specialBtn = display.newImage( myImageSheet , sheetInfo:getFrameIndex("weaponBtn"))
	specialBtn.x = 460
	specialBtn.y = 230
	specialBtn:scale( 0.20, 0.20 )	]]--




function onCollision( event )


		objectName = tostring(event.object1.name)
		
		local caty = cat.y
		local catx = cat.x	
		j = 0

        if ( event.phase == "began" ) then
		
				if ((event.object1.name == "weaponBlast" and event.object2.name == "alien") or (event.object2.name == "weaponBlast" and event.object1.name == "alien")) then
					if (event.object1.name == "alien") then
						j = event.object1.id
						print (j)
					else
						j = event.object2.id
						print (j)
					end
					--print ("move alien")
					dangerousAlien = false
					score = score + 200
					screenText.text = ("Zing: " .. score)
					timerIndex[40] = timer.performWithDelay( 1, explodeAlien(event, j), 1)		
				end

				
				if ((event.object1.name == "weaponBlast" and event.object2.name == "laser") or (event.object2.name == "weaponBlast" and event.object1.name == "laser")) then
					if (event.object1.name == "laser") then
						j = event.object1.id
						print (j)
					else
						j = event.object2.id
						print (j)
					end
					--print ("move laser")
					dangerousLaser = false
					score = score + 200
					screenText.text = ("Zing: " .. score)
					timerIndex[40] = timer.performWithDelay( 1, explodeLaser(event, j), 1)	
				end
				
				
				if ((event.object2.name == "cat" and event.object1.name == "warpGateZing"  and warpScore == true) or (event.object1.name == "cat" and event.object2.name == "warpGateZing" and warpScore == true)) then
				warpScore = false
				score = score + 1000
				screenText.text = ("Zing: " .. score)
				end			
				
				if ((event.object2.name == "weaponBlast" and event.object1.name == "ufo") or (event.object1.name == "weaponBlast" and event.object2.name == "ufo")) then
				--print ("explode ufo")
				dangerousUFO = false
				score = score + 100
				screenText.text = ("Zing: " .. score)
				Particles.StartEmitter("E1")
				timerIndex[41] = timer.performWithDelay( 1, explodeUFO(), 1)			
				end
				
				if ((event.object2.name == "weaponBlast" and event.object1.name == "bunny") or (event.object1.name == "weaponBlast" and event.object2.name == "bunny")) then
				--print ("explode bunny")
				dangerousBunny = false
				score = score + 100
				screenText.text = ("Zing: " .. score)
				Particles.StartEmitter("E1")
				timerIndex[41] = timer.performWithDelay( 1, explodeBunny(), 1)			
				end
				
				if ((event.object2.name == "weaponBlast" and event.object1.name == "EvilMouse") or (event.object1.name == "weaponBlast" and event.object2.name == "EvilMouse")) then
				--print ("destroy mouse")
				score = score + 500
				screenText.text = ("Zing: " .. score)
				timerIndex[42] = timer.performWithDelay( 1, destroyMouse(), 1)			
				end
				
				if ((event.object1.name == "ufo" and event.object2.name == "cat" and dangerousUFO == true) or (event.object1.name == "cat" and event.object2.name == "ufo" and dangerousUFO == true)) then
				Runtime:removeEventListener("touch", screenTouched)
				if (gameSettings[2] == "true") then
				audio.play( catDieSound )
				end
				--print ("dead cat from ufo")
				timer.performWithDelay(1, catDie(event), 1)
				end
				
				if ((event.object1.name == "alien" and event.object2.name == "cat" and dangerousAlien == true) or (event.object1.name == "cat" and event.object2.name == "alien" and dangerousAlien == true)) then
				Runtime:removeEventListener("touch", screenTouched)
				if (gameSettings[2] == "true") then
				audio.play( catDieSound )
				end
				--print ("dead cat from alien")
				timer.performWithDelay(1, catDie(event), 1)
				end
				
				if ((event.object1.name == "bunny" and event.object2.name == "cat" and dangerousBunny == true) or (event.object1.name == "cat" and event.object2.name == "bunny" and dangerousBunny == true)) then
				Runtime:removeEventListener("touch", screenTouched)
				if (gameSettings[2] == "true") then
				audio.play( catDieSound )
				end
				--print ("dead cat from bunny")
				timer.performWithDelay(1, catDie(event), 1)
				end
				
				if ((event.object1.name == "laser" and event.object2.name == "cat" and dangerousLaser == true) or (event.object1.name == "cat" and event.object2.name == "laser" and dangerousLaser == true)) then
				Runtime:removeEventListener("touch", screenTouched)
				if (gameSettings[2] == "true") then
				audio.play( catDieSound )
				end
				--print ("dead cat from laser")
				timer.performWithDelay(1, catDie(event), 1)
				end
				
				if ((event.object1.name == "beam" and event.object2.name == "cat" and dangerousBeam == true) or (event.object1.name == "cat" and event.object2.name == "beam" and dangerousBeam == true)) then
				Runtime:removeEventListener("touch", screenTouched)
				if (gameSettings[2] == "true") then
				audio.play( catDieSound )
				end
				--print ("dead cat from beam")
				timer.performWithDelay(1, catDie(event), 1)
				end

				
                print( "Contact began: " .. event.object1.name .. " & " .. event.object2.name )
				
 
        elseif ( event.phase == "ended" ) then
	
 
                --print( "ended: " .. event.object1.name .. " & " .. event.object2.name )
				
				return

				 
        end

end


function explodeAlien(event, q)
return function()
		if (alien ~= nil) then
				if(alien[q].x > -200) then
				tnt:newTimer(1, function() alien[q].y = alien[q].y -10 end, 1)
				else
				dangerousAlien = true
				--timer.cancel( event.source )
				return
				end
	timerIndex[52] = timer.performWithDelay( 1, explodeAlien(event, q), 1 )
		end
end
end



function destroyMouse(event)

		EvilMouse:removeSelf()
		EvilMouse = display.newImage("smoke.png")
		screenGroup:insert( EvilMouse )
		EvilMouse.x = 300
		EvilMouse.y = 300

end



function catDie(event)

	if (cat.y < 400) then
		cat.y = cat.y + 10
	else
		timer.cancel( event.source )
		print ("ending cat fall!!!!!!!")
		cat:pause()
		print ("Dead Cat: ", deadCat)
		gameIsActive = false
		physics.pause()
		tnt:pauseAllTimers()
		print ("restart level")
		timer.performWithDelay(1000, exitLevel(event, "reload"), 1)
		print ("restart level")
	return
	end
		tnt:newTimer( 1, catDie, 1 )

end


function explodeUFO(event)
										
				-- TRIGGER THE EMITTERS
				
				if(ufo.x > -800) then
				Emitter1.x = ufo.x
				Emitter1.y = ufo.y
				tnt:newTimer(1, function() ufo.y = ufo.y + 5 end, 1)
				Particles.Update()
				else
				print "all done!!!!!!!!!!!!!!!!!!"
				dangerousUFO = true
				Particles.StopEmitter("E1")
				timer.cancel( event.source )
				return
				end	
				

		
		tnt:newTimer( 33, explodeUFO, 1, {event} )
end

function explodeBunny(event)
										
				-- TRIGGER THE EMITTERS
			if (bunny ~= nil) then	
				if(bunny.x > -800) then
				Emitter1.x = bunny.x
				Emitter1.y = bunny.y
				tnt:newTimer(1, function() bunny.y = bunny.y + 5 end, 1)
				Particles.Update()
				else
				print "all done!!!!!!!!!!!!!!!!!!"
				Particles.StopEmitter("E1")
				timer.cancel( event.source )
				return
				end	
			end
		
		tnt:newTimer( 33, explodeBunny, 1, {event} )
end


function explodeLaser(event, q)
return function()
				if(laser[q].x > -200) then
				tnt:newTimer(1, function() laser[q].y = laser[q].y -10 end, 1)
				else
				dangerousLaser = true
				--timer.cancel( event.source )
				return
				end
	timerIndex[52] = timer.performWithDelay( 1, explodeLaser(event, q), 1 )
end
end


function screenTouched(event)

if(event.x < 300) then
	if (gameIsActive == true) then
		if event.phase == "began" then
			moveY = event.y - cat.y
		elseif event.phase == "moved" then
			cat.y = event.y - moveY
		end
		
		if((cat.y - cat.height * 0.10) < 0) then
			cat.y = cat.height * 0.10
		elseif((cat.y + cat.height * 0.05) > display.contentHeight) then
			cat.y = display.contentHeight - cat.height * 0.05
			cat.y = 301
		end
	end
end
end

function weaponTouched(event)

if event.phase == "began" then
print "Weapon Button Touched"
	weaponBlast = display.newSprite( myImageSheet , sequenceData2)
	--weaponBlast.name = "weaponBlast"
	weaponBlast.name = "weaponBlast"
	--weaponBlast:scale( 0.20, 0.20 )
weaponBlast.x = cat.x + 110
weaponBlast.y = cat.y + 15
weaponCollisionFilter = { categoryBits = 8, maskBits = 6 }
physics.addBody( weaponBlast, dynamic, { density=1, friction=0, bounce=15.0, radius=0.15, filter=weaponCollisionFilter } )
weaponBlast:play()
weaponBtn:removeEventListener("touch", weaponTouched)


timer.performWithDelay(100, stayCat, 11)


end
end


function stayCat()

if(iter <= 5) then
weaponBlast.y = cat.y + 15
iter = iter + 1
elseif(iter == 6) then
weaponBlast:removeSelf()
iter = iter + 1
elseif(iter == 10) then
weaponBtn:addEventListener("touch", weaponTouched)
iter = 0
--print(iter)
else
iter = iter + 1
end

end


function exitLevel(event, q)
		
		print ("Yooooo!!!! ", q)
		
			gameOn = false
			score = nil
		
		timer.performWithDelay(1, physics.start(), 1)
		timer.performWithDelay(1, physics.stop(), 1)
		
		--audio.dispose( catDieSound )

		if (q == "reload") then
				local mission3 =
				{
					effect = "fade",
					time = 100,
					params =
					{
						var1 = "level3",
					}
				}
		
			Runtime:removeEventListener("touch", screenTouched)
			Runtime:removeEventListener( "collision", onCollision)
			Particles.StopEmitter("E1")
			Particles.CleanUp()
			tnt:cancelAllTimers()
			print ("going to reboot!!!!")
			timer.performWithDelay(1000, function() storyboard.gotoScene( "reloadLevel", mission3 ) end, 1)
		else
			Runtime:removeEventListener( "collision", onCollision)
			Runtime:removeEventListener("touch", screenTouched)
			Particles.StopEmitter("E1")
			Particles.CleanUp()
			tnt:cancelAllTransitions()
			tnt:cancelAllTimers()
			storyboard.removeScene("level3")
			storyboard.gotoScene( "exitTheLevel", "fade", 100 )
			print "\ngoing to Levels screen"
		end
		
end

function levelDefeat()

	gameIsActive = false

	local contents2 = fh2:read( "*a" )
	
	local k = 1
	local j = string.len(contents2)
	local gameSettings2 = {}
		
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
	
	-- Used for full version
	--local scoreTemp = score + tonumber(gameSettings2[2])
	local scoreTemp = 0
	
	if (tonumber(gameSettings2[1]) <= 1) then
	levelTemp = 3
	print ("Game Settings 1: ", gameSettings2[1], ", levelTemp: ", tostring(levelTemp))
	else
	levelTemp = gameSettings2[1]
	print ("Game Settings 2: ", gameSettings2[1])
	end
	
	print ("WRITING: ", levelTemp)
	
	fh2 = io.open( path2, "w" )
	fh2:write( tostring(levelTemp), ",", tostring(scoreTemp))
	io.close( fh2 )
	
	
	pauseBtn.x = 700
	weaponBtn.x = 700
	
	endInfo = display.newRoundedRect(30, 50, 400, 260, 12)
	endInfo.strokeWidth = 3
	endInfo:setFillColor(blue)
	endInfo.alpha = 0.75
	screenGroup:insert( endInfo )
	
	local endText = display.newText("Congratulations!!!  Mission 3 Success...\n\n", 35, 55, "Arial", 16)
		endText:setTextColor( 255, 255, 0 )
		screenGroup:insert( endText )
	local endScore = display.newText("Zing Achieved for Mission: " .. score, 35, 100, "Arial", 16)
		endScore:setTextColor( 124,252,0 )
		screenGroup:insert( endScore )
	local totalScore = display.newText("Total Zing Accumulation: Not Tracked in Free Version", 35, 145, "Arial", 16)
		totalScore:setTextColor( 124,252,0 )
		screenGroup:insert( totalScore )
	local exitInfo = display.newText("Click Exit Level to Continue...", 35, 190, "Arial", 16)
		exitInfo:setTextColor( 124,252,0 )
		screenGroup:insert( exitInfo )
	
	
	ExitBtn = ui.newButton{
		defaultSrc = "ExitBtn.png",
		defaultX = 80,
		defaultY = 40,
		onEvent = exitLevel,
		id = "ExitButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}	
	
	screenGroup:insert( ExitBtn )
	ExitBtn.x = 350
	ExitBtn.y = 290
	
	print("Game Status End of Level: ", gameIsActive)

end


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
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
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
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	end
	musicBtn.x = 125; musicBtn.y = 150
	screenGroup:insert( musicBtn )
end

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
		id = "SoundFXButton",
		text = "",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	end	
	soundfxBtn.x = 125; soundfxBtn.y = 225
	screenGroup:insert( soundfxBtn )
end	


function updateBackgrounds()

-- print ("Grass x: ", Grass.x)
if (gameIsActive == true) then
--far background movement
jungleback.x = jungleback.x - (speed/10)
jungleback2.x = jungleback2.x - (speed/12)
jungleback3.x = jungleback3.x - (speed/13)
--near background movement
brush.x = brush.x - (speed/4)
brush2.x = brush2.x - (speed/3)
brush3.x = brush3.x - (speed/4)
brush4.x = brush4.x - (speed/3)
Grass.x = Grass.x - (speed/1)
Grass3.x = Grass3.x - (speed/1)
Tree.x = Tree.x - (speed/5)
Tree2.x = Tree2.x - (speed/8)
Tree3.x = Tree3.x - (speed/2)
--if the sprite has moved off the screen move it back to the
--other side so it will move back on
if(jungleback.x < -239) then
jungleback.x = 760
end
if(jungleback2.x < -239) then
jungleback2.x = 780
end
if(jungleback3.x < -239) then
jungleback3.x = 760
end
if(Grass.x < -239) then
Grass.x = 760
end
if(Grass3.x < -239) then
Grass3.x = 760
end
if(brush.x < -239) then
brush.x = 760
end
if(brush2.x < -239) then
brush2.x = 760
end
if(brush3.x < -239) then
brush3.x = 760
end
if(brush4.x < -239) then
brush4.x = 760
end
if(Tree.x < -239) then
Tree.x = 760
end
if(Tree2.x < -239) then
Tree2.x = 760
end
if(Tree3.x < -239) then
Tree3.x = 760
end
end
tnt:newTimer(1, updateBackgrounds, 1)
end


local q = 0
local rot = 0
function beamTrigger(event, v, rot)
return function()
if (gameIsActive == true) then
if (v == 1) then
	timerIndex[60] = timer.performWithDelay(1, updateBeams(1, rot), 1)
elseif (v == 2) then
	timerIndex[61] = timer.performWithDelay(1, updateBeams(2, rot), 1)
	timerIndex[62] = timer.performWithDelay(1, updateBeams(3, rot), 1)
elseif (v == 3) then
	timerIndex[63] = timer.performWithDelay(1, updateBeams(4, rot), 1)
	timerIndex[64] = timer.performWithDelay(1, updateBeams(5, rot), 1)
	timerIndex[65] = timer.performWithDelay(1, updateBeams(6, rot), 1)
else
		q = 66
	for n = 7, 50 do
		timer.performWithDelay(1, updateBeams(n), 1)
		--print ("Timer Index Q: ", q, " , ", timerIndex[q])
		q = q + 1
	end
	
		q = 110
	for z = 51, 94 do
		timer.performWithDelay(1, updateBeams(z), 1)
		--print ("Timer Index Q: ", q, " , ", timerIndex[q])
		q = q + 1
	end
	q = 0
end
end
end
end


function updateBeams(v, rot)

return function()
--print (beam[v].x)
if (gameIsActive == true) then
	if (beam[v] ~= nil) then
	if (beam[v].x > -239) then
		--print (v, ": ", beam[v].y)
		beam[v].x = beam[v].x - (speed/1)
		--print ("rot: ", rot)
			if (rot == 1) then
				print "rotating"
				rot = 0
				timer.performWithDelay(1, rotateBeam(v), 1)
			end
		end
	else
	if (v >= 7) then
				if (beam[v] ~= nil) then
				beam[v]:removeSelf()
				beam[v] = nil
				end
		end
	--beam[v].x = 760
	--timer.cancel( timerIndex[25] )
	return
	end
	
end
		tnt:newTimer(1, updateBeams(v, rot), 1)
end
end

function rotateBeam(q)

return function()
if (gameIsActive == true) then
	if (beam[q] ~= nil and beam[q].x > -239) then
		print "rotating function"
		beam[q]:rotate(90)	
	else
		print "return"
		return
	end
end
		tnt:newTimer(1000, rotateBeam(q), 1)
end
end


local laserCount = 0

function ufoFlight(event)

if (gameIsActive == true) then
	if(ufo.x < -810) then
	ufo.x = 760
	ufo.y = 0
	laserCount = 0
	--Particles.StopEmitter("E1")
	timer.cancel(event.source)
	return
	else
	ufo.x = ufo.x - (speed/1)
	end
	
	if(ufo.x > 300) then
	ufo.y = cat.y
	else
	ufo.y = ufo.y
	end
	
	if ((ufo.x <= 700) and (laserCount == 0)) then
	laserCount = 1
	tnt:newTimer(100, updateLaser(event, 1), 1)
	tnt:newTimer(500, updateLaser(event, 2), 1)
	tnt:newTimer(800, updateLaser(event, 3), 1)
	end
	
end	
	
		tnt:newTimer(1, ufoFlight, 1)
end


function bunnyFlight(event)

if (gameIsActive == true) then
	if(bunny.x < -810) then
	bunny.x = 760
	bunny.y = 0
	--Particles.StopEmitter("E1")
	--timer.cancel(event.source)
	return
	else
	bunny.x = bunny.x - (speed/.75)
	end
	
	if(bunny.x > 300) then
	bunny.y = cat.y
	else
	bunny.y = bunny.y
	end
end	
	
		tnt:newTimer(1, bunnyFlight, 1)
end


local mouseNum = 1
function mouseRun(event)

print ("EvilMouse: ", mouseNum, " : ", EvilMouse.x)
if (gameIsActive == true) then

	if(EvilMouse.x > -239) then
	EvilMouse.x = EvilMouse.x - (speed/1)
	else
	EvilMouse = display.newImage( myImageSheet , sheetInfo:getFrameIndex("EvilMouse"))
	physics.addBody( EvilMouse, dynamic, { density=1, friction=0, bounce=15.0, radius=ufo.radius, filter=jetCollisionFilter } )
	EvilMouse.isSensor = true
	EvilMouse.name = "EvilMouse"
	EvilMouse.x = 760
	EvilMouse.y = 300
	timer.cancel( event.source )
	mouseNum = mouseNum + 1
	return
	end
	
	timerIndex[21] = timer.performWithDelay(1, mouseRun, 1)
end	

end


local catAlpha = 0.5

function endLevel(event)

--print("end gate move: ", endLevelGate.x)
if (gameIsActive == true) then
	if (endLevelGate.x > 0) then
		endLevelGate.x = endLevelGate.x - (speed/2)
		if (endLevelGate.x <= 170 and catAlpha > 0) then
			cat.alpha = catAlpha
			catAlpha = catAlpha - 0.01
		end
	else
	print ("The End!!!!!!!!!!")
	timer.performWithDelay(1000, levelDefeat(), 1)
	return
	end	

end
	tnt:newTimer(1, endLevel, 1, {event})
end


function updateWarpGate()
	yAxisRandom = math.random (20, 180)
	warpGateZing.y = yAxisRandom
	print("update gate")
	warpGateMove(event)
end
	


function warpGateMove(event)
--print("warp gate move: ", warpGateZing.x)
if (gameIsActive == true) then
	if (warpGateZing.x > -239) then
		warpGateZing.x = warpGateZing.x - (speed/1)
	else
	warpGateZing.x = 760
	warpScore = true
	--timer.cancel(timerIndex[56])
	return
	end	

end
	tnt:newTimer(1, warpGateMove, 1, {event})
end


function updateLaser( event, v)
return function()

	if laser[v] == nil then
	print "no laser available"
	else
	laser[v].y = ufo.y
	laser[v].x = ufo.x
	print ("Laser y:" .. laser[v].id .. " " .. laser[v].y)
	end
	timer.performWithDelay(1, laserFlight(v), 1)
end
end



function laserFlight(q)
return function()
--print ("double check y: " .. jet[j].y)
if (gameIsActive == true) then
	if laser[q] == nil then
		print "no jet available 2"
	elseif (laser[q].x > -239) then
		--print ("Jet Flight:" .. jet[j].id .. " " .. jet[j].x)
		laser[q].x = laser[q].x - (speed/.5)
		--print (jet[j].x)
	else
	laser[q].x = 760
	print ("laser reset: ", laser[q].name)
	--timer.cancel(timerIndex[22])
	return
	end	
end
	tnt:newTimer(1, laserFlight(q), 1)
end
end

function updateAlien( v )
return function()
	yAxisRandom = math.random (20, 250)
	print ("yAxisRandom:" .. yAxisRandom)
	print ("Find Alien:" .. v)
	if alien[v] == nil then
	print "no jet available"
	else
	alien[v].y = yAxisRandom
	print ("Jet y:" .. alien[v].id .. " " .. alien[v].y)
	end
	timer.performWithDelay(1, alienFlight(v), 1)
end
end

function alienFlight(q)
return function()
--print ("double check y: " .. jet[j].y)
if (gameIsActive == true) then
	if alien[q] == nil then
		print "no jet available 2"
	elseif (alien[q].x > -239) then
		--print ("Jet Flight:" .. jet[j].id .. " " .. jet[j].x)
		alien[q].x = alien[q].x - (speed/.8)
		--print (jet[j].x)
	else
	alien[q].x = 760
	print ("alien reset: ", alien[q].name)
	--timer.cancel(timerIndex[57])
	return
	end	
end
	tnt:newTimer(1, alienFlight(q), 1)
end
end



function pauseTouched(event)

local gameStatus = tostring(gameIsActive)


print ("pause touched")
if (gameIsActive == true) then
	gameIsActive = false
	cat:pause()	
	pauseBtn.x = 700
	weaponBtn.x = 700
	pauseInfo = display.newRoundedRect(30, 50, 400, 260, 12)
	pauseInfo.strokeWidth = 3
	pauseInfo:setFillColor(blue)
	pauseInfo.alpha = 0.75
	screenGroup:insert( pauseInfo )
	pauseText = display.newText("Game Paused...", 35, 55, "Arial", 12)
	screenGroup:insert( pauseText )
	pauseBtn2 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("playGameBtn"))
	pauseBtn2.x = 340
	pauseBtn2.y = 240
	pauseBtn2:scale( 2, 1.7 )
	pauseBtn2:addEventListener("tap", pauseTouched)	
	screenGroup:insert( pauseBtn2 )
	pauseText2 = display.newText("Play", 320, 232, "Arial", 12)
	pauseText2:setTextColor( black )
	screenGroup:insert( pauseText2 )
	ExitBtn = ui.newButton{
		defaultSrc = "ExitBtn.png",
		defaultX = 80,
		defaultY = 40,
		onEvent = exitLevel,
		id = "ExitButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	screenGroup:insert( ExitBtn )
	ExitBtn.x = 350
	ExitBtn.y = 290
	musicStatus()
	soundfxStatus()
	physics.pause()
	tnt:pauseAllTimers()
	print("Game Status in Pause BTN: ", gameIsActive)
else 
	gameIsActive = true
	cat:play()	
	pauseBtn2:removeSelf()
	pauseText2:removeSelf()
	pauseInfo:removeSelf()
	pauseText:removeSelf()
	musicBtn:removeSelf()
	soundfxBtn:removeSelf()
	ExitBtn:removeSelf()
	pauseBtn.x = 460
	weaponBtn.x = 440
	physics.start()
	tnt:resumeAllTimers()
	print("Game Status in Pause BTN: ", gameIsActive)
end

end


function gameListeners(event)
	if event == "add" then
		Runtime:addEventListener( "collision", onCollision)
		Runtime:addEventListener("touch", screenTouched)
		weaponBtn:addEventListener("touch", weaponTouched)
		--specialBtn:addEventListener("tap", specialTouched)		
		
	end
end

function pauseListener(event)

if event == "add" then
	pauseBtn:addEventListener("tap", pauseTouched)
end

end


function gameStart()

	pauseListener("add")
	score = nil
	score = 0
	gameListeners("add")
	
	screenText = display.newText("Zing: " .. score, 20, 0, "Arial", 12)
	screenGroup:insert( screenText )
	
	updateBackgrounds()

	tnt:newTimer(1000, beamTrigger(event, 1, 1), 1)
	tnt:newTimer(5000, bunnyFlight, 1)
	tnt:newTimer(7000, ufoFlight, 1)
	tnt:newTimer(10000, beamTrigger(event, 2, 0), 1)
	tnt:newTimer(13000, beamTrigger(event, 3, 1), 1)
	tnt:newTimer(14000, updateWarpGate, 1)
	--tnt:newTimer(16000, updateAlien(1), 1)
	--tnt:newTimer(16000, updateAlien(2), 1)
	--tnt:newTimer(16000, updateAlien(3), 1)
	tnt:newTimer(19000, createBeamTunnel, 1)
	tnt:newTimer(21000, beamTrigger(event, 4, 0), 1)
	tnt:newTimer(26000, ufoFlight, 1)
	tnt:newTimer(32000, bunnyFlight, 1)
	--tnt:newTimer(36000, updateWarpGate, 1)
	tnt:newTimer(40000, beamTrigger(event, 2, 0), 1)
	tnt:newTimer(41000, updateAlien(1), 1)
	tnt:newTimer(41000, updateAlien(2), 1)
	--tnt:newTimer(41000, updateAlien(3), 1)
	--tnt:newTimer(43000, updateAlien(4), 1)
	--tnt:newTimer(43000, updateAlien(5), 1)
	tnt:newTimer(47000, ufoFlight, 1)
	tnt:newTimer(50000, beamTrigger(event, 3, 1), 1)
	tnt:newTimer(52000, updateWarpGate, 1)
	tnt:newTimer(58000, beamTrigger(event, 1, 1), 1)
	tnt:newTimer(62000, updateAlien(1), 1)
	tnt:newTimer(62000, updateAlien(2), 1)
	tnt:newTimer(65000, updateAlien(3), 1)
	--tnt:newTimer(65000, updateAlien(4), 1)
	--tnt:newTimer(65000, updateAlien(5), 1)
	--tnt:newTimer(71000, ufoFlight, 1)
	--tnt:newTimer(74000, updateWarpGate, 1)
	tnt:newTimer(80000, beamTrigger(event, 3, 1), 1)
	--tnt:newTimer(73000, bunnyFlight, 1)
	tnt:newTimer(83000, updateAlien(1), 1)
	tnt:newTimer(83000, updateAlien(2), 1)
	--tnt:newTimer(85000, updateAlien(3), 1)
	--tnt:newTimer(75000, updateAlien(4), 1)
	--tnt:newTimer(75000, updateAlien(5), 1)
	tnt:newTimer(85000, endLevel, 1)
	
	
end


gameStart()
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
for n=1, #beam do
if (beam[n] ~= nil) then
beam[n]:removeSelf()
beam[n] = nil
end
end
	storyboard.purgeScene()
	Runtime:removeEventListener( "collision", onCollision)
	print( "level3: exitScene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print( "((destroying level3's view))" )
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



