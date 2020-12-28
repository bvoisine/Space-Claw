---------------------------------------------------------------------------------
--
-- level1.lua
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
	
	print( "\nlevel 1: createScene event" )
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
local moveY
local jetName
local isAlive = true
local dangerousJet = true
local dangerousUFO = true
local iter = 0
local gameIsActive = true 
local update
local yAxisRandom
local speed = 5
local warpScore = true



	local myImageSheet = graphics.newImageSheet( "sprites.png", sheetInfo:getSheet() )



-- Larger images
	sky = display.newImage("BlueSky.png")
	screenGroup:insert( sky )
	
	badCloud2 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("BadCloud"))
	badCloud2.x = 300
	badCloud2.y = 30
	badCloud2:scale( 0.25, 0.25 )
	screenGroup:insert( badCloud2 )
	
	badCloud = display.newImage( myImageSheet , sheetInfo:getFrameIndex("BadCloud"))
	badCloud.x = 240
	badCloud.y = 50
	badCloud:scale( 0.40, 0.40 )
	screenGroup:insert( badCloud )

	City2 = display.newImage("City2.png")
	City2.x = 780
	screenGroup:insert( City2 )
	
	City = display.newImage("City.png")
	City.x = 240
	screenGroup:insert( City )
	

	Tree = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Tree"))
	Tree.y = 240
	Tree.x = 220
	screenGroup:insert( Tree )

	Tree2 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Tree2"))
	Tree2.y = 220
	Tree2.x = 760
	screenGroup:insert( Tree2 )
	
	Tree3 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Tree2"))
	Tree3.y = 220
	Tree3.x = 300
	screenGroup:insert( Tree3 )

	
	Tree1 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Tree"))
	Tree1.y = 240
	Tree1.x = 460
	screenGroup:insert( Tree1 )

	--Tree:scale( 0.25, 0.25 )	
	Tree1:scale( 0.7, 0.7 )	
	Tree2:scale( 1, 1 )	
	Tree3:scale( 1, 1 )	
	House = display.newImage("House.png")
	House.x = 240
	screenGroup:insert( House )

local jet = {}
	
-- Create Jets
for a = 1, 3 do
	jet[a] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("jet"))
	jet[a].x = 760
	jet[a].collision = onLocalCollision
	jet[a].radius = 0.15
	jet[a].myName = "jet"
	jet[a].name = "jet"
	jetCollisionFilter = { categoryBits = 2, maskBits = 9 }
	physics.addBody( jet[a], dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, shape = {   -144, -42  ,  -178, -53  ,  -171, -65  ,  -147, -67 }, filter=jetCollisionFilter } )
	jet[a].isSensor = true
    jet[a].id = (a)
	screenGroup:insert( jet[a] )
end




	local ufo = display.newImage( myImageSheet , sheetInfo:getFrameIndex("BadShip"))
	ufo.x = 760
	ufo.name = "ufo"
	ufo.id = "ufo"
	physics.addBody( ufo, dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, filter=jetCollisionFilter } )
	ufo.isSensor = true
	screenGroup:insert( ufo )

	
	local ufoFlag = 0
	
	

	
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


	-- Cat
	local cat = display.newSprite( myImageSheet, sequenceData )
	cat.x = 80
	cat.y = 100
	cat.name = "cat"
	cat.myName = "cat"
	cat.rotation = 0  
	physics.addBody( cat, dynamic, { density=1, friction=0, bounce=0, radius=jet.radius, shape = { -97, -145  ,  -187, -166  ,  -122, -195 }, filter=jetCollisionFilter } )
	cat.isSensor = true
	cat:play()
	screenGroup:insert( cat )
	
	local EvilMouse = display.newImage( myImageSheet , sheetInfo:getFrameIndex("EvilMouse"))
	physics.addBody( EvilMouse, dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, filter=jetCollisionFilter } )
	EvilMouse.isSensor = true
	EvilMouse.name = "EvilMouse"
	EvilMouse.x = 760
	EvilMouse.y = 300
	screenGroup:insert( EvilMouse )
	
	local warpGateZing = display.newImage( myImageSheet , sheetInfo:getFrameIndex("warpGateZing"))
	physics.addBody( warpGateZing, dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, filter=jetCollisionFilter } )
	warpGateZing.isSensor = true
	warpGateZing.name = "warpGateZing"
	warpGateZing.x = 760
	warpGateZing.y = 300
	screenGroup:insert( warpGateZing )
	
	local endLevelGate = display.newImage( "endLevelGate.png" )
	physics.addBody( endLevelGate, dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, filter=jetCollisionFilter } )
	endLevelGate.isSensor = true
	endLevelGate.name = "endLevelGate"
	endLevelGate.x = 760
	endLevelGate.y = 150
	screenGroup:insert( endLevelGate )
	
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
	
	
	--[[local specialBtn = display.newImage( myImageSheet , sheetInfo:getFrameIndex("weaponBtn"))
	specialBtn.x = 460
	specialBtn.y = 230
	specialBtn:scale( 0.20, 0.20 )	]]--
	
	local TutorialInGame = display.newImage("TutorialInGame.png")
	screenGroup:insert( TutorialInGame )


function onCollision( event )


		objectName = tostring(event.object1.name)
		
		local caty = cat.y
		local catx = cat.x	
		j = 0

        if ( event.phase == "began" ) then

				
				if ((event.object1.name == "weaponBlast" and event.object2.name == "jet") or (event.object2.name == "weaponBlast" and event.object1.name == "jet")) then
					if (event.object1.name == "jet") then
						j = event.object1.id
						print (j)
					else
						j = event.object2.id
						print (j)
					end
					print ("move jet")
					dangerousJet = false
					score = score + 200
					screenText.text = ("Zing: " .. score)
					timer.performWithDelay( 1, explodeJet(event, j), 1)		
				end
				
				if ((event.object2.name == "cat" and event.object1.name == "warpGateZing" and warpScore == true) or (event.object1.name == "cat" and event.object2.name == "warpGateZing" and warpScore == true)) then
				warpScore = false
				score = score + 100
				screenText.text = ("Zing: " .. score)
				end
				
				if ((event.object1.name == "ufo" and event.object2.name == "cat" and dangerousUFO == true) or (event.object1.name == "cat" and event.object2.name == "ufo" and dangerousUFO == true)) then
				Runtime:removeEventListener("touch", screenTouched)
				print ("dead cat from ufo")
				if (gameSettings[2] == "true") then
				audio.play( catDieSound )
				end
				timer.performWithDelay(1, catDie(event), 1)
				end
				
				if ((event.object1.name == "jet" and event.object2.name == "cat" and dangerousJet == true) or (event.object1.name == "cat" and event.object2.name == "jet" and dangerousJet == true)) then
				Runtime:removeEventListener("touch", screenTouched)
				print ("dead cat from jet")
				if (gameSettings[2] == "true") then
				audio.play( catDieSound )
				end
				timer.performWithDelay(1, catDie(event), 1)
				end
				
				
				if ((event.object2.name == "weaponBlast" and event.object1.name == "ufo") or (event.object1.name == "weaponBlast" and event.object2.name == "ufo")) then
				print ("explode ufo")
				dangerousUFO = false
				score = score + 100
				screenText.text = ("Zing: " .. score)
				Particles.StartEmitter("E1")
				timer.performWithDelay(1, explodeUFO(), 1)
				end
				
				
				if ((event.object2.name == "weaponBlast" and event.object1.name == "EvilMouse") or (event.object1.name == "weaponBlast" and event.object2.name == "EvilMouse")) then
				print ("destroy mouse")
				score = score + 500
				screenText.text = ("Zing: " .. score)
				destroyMouse()
				end

				
                print( "Contact began: " .. event.object1.name .. " & " .. event.object2.name )

 
        elseif ( event.phase == "ended" ) then
	
 
                print( "ended: " .. event.object1.name .. " & " .. event.object2.name )
				
				return

				 
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



function explodeJet(event, q)
return function()
				if(jet[q].x > -200) then
				tnt:newTimer(1, function() jet[q].y = jet[q].y -10 end, 1)
				else
				dangerousJet = true
				timer.cancel( timerIndex[52] )
				return
				end
	timerIndex[52] = timer.performWithDelay( 1, explodeJet(event, q), 1 )
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
		
		if (cat.height ~= nil) then
		if((cat.y - cat.height * 0.10) < 0) then
			cat.y = cat.height * 0.10
		elseif((cat.y + cat.height * 0.05) > display.contentHeight) then
			cat.y = display.contentHeight - cat.height * 0.05
			cat.y = 301
		end
		end
	end
end
end

function weaponTouched(event)

if event.phase == "began" then
print "Weapon Button Touched"
	weaponBlast = display.newSprite( myImageSheet , sequenceData2)
	weaponBlast.name = "weaponBlast"
weaponBlast.x = cat.x + 110
weaponBlast.y = cat.y + 15
weaponCollisionFilter = { categoryBits = 8, maskBits = 6 }
physics.addBody( weaponBlast, dynamic, { density=1, friction=0, bounce=15.0, radius=0.15, filter=weaponCollisionFilter } )
weaponBlast:play()
weaponBtn:removeEventListener("touch", weaponTouched)


tnt:newTimer(100, stayCat, 11)

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
				local mission1 =
				{
					effect = "fade",
					time = 100,
					params =
					{
						var1 = "level1",
					}
				}
		
			Runtime:removeEventListener("touch", screenTouched)
			Runtime:removeEventListener( "collision", onCollision)
			Particles.StopEmitter("E1")
			Particles.CleanUp()
			tnt:cancelAllTimers()
			print ("going to reboot!!!!")
			timer.performWithDelay(1000, function() storyboard.gotoScene( "reloadLevel", mission1 ) end, 1)
		else
			Runtime:removeEventListener( "collision", onCollision)
			Runtime:removeEventListener("touch", screenTouched)
			Particles.StopEmitter("E1")
			Particles.CleanUp()
			tnt:cancelAllTransitions()
			tnt:cancelAllTimers()
			storyboard.removeScene("level1")
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
	levelTemp = 1
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
	
	local endText = display.newText("Congratulations!!!\n\n\n", 35, 100, "Arial", 22)
		endText:setTextColor( 255, 255, 0 )
		screenGroup:insert( endText )
	local endScore = display.newText("               Mission 1 Zing: " .. score, 35, 165, "Arial", 24)
		endScore:setTextColor( 124,252,0 )
		screenGroup:insert( endScore )	
	
	
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

if (gameIsActive == true) then
--far background movement
City.x = City.x - (speed/10)
City2.x = City2.x - (speed/12)
badCloud2.x = badCloud2.x - (speed/15)
badCloud.x = badCloud.x - (speed/12)
--near background movement
House.x = House.x - (speed/2)
Grass.x = Grass.x - (speed/1)
Grass3.x = Grass3.x - (speed/1)
Tree.x = Tree.x - (speed/6)
Tree1.x = Tree1.x - (speed/5)
Tree2.x = Tree2.x - (speed/8)
Tree3.x = Tree3.x - (speed/6)
--if the sprite has moved off the screen move it back to the
--other side so it will move back on
if(badCloud.x < -239) then
badCloud.x = 600
end
if(badCloud2.x < -239) then
badCloud2.x = 700
end
if(City.x < -239) then
City.x = 760
end
if(City.x < -239) then
City.x = 780
end
if(House.x < -239) then
House.x = 760
end
if(Grass.x < -239) then
Grass.x = 760
end
if(Grass3.x < -239) then
Grass3.x = 760
end
if(Tree.x < -239) then
Tree.x = 760
end
if(Tree1.x < -239) then
Tree1.x = 760
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


function ufoFlight(event)


if (gameIsActive == true) then
	if(ufo.x < -810) then
	ufo.x = 760
	ufo.y = 0
	--Particles.StopEmitter("E1")
	--timer.cancel(event.source)
	return
	else
	ufo.x = ufo.x - (speed/1)
	end
	
	if(ufo.x > 300) then
	ufo.y = cat.y
	else
	ufo.y = ufo.y
	end
end	
	
	tnt:newTimer(1, ufoFlight, 1, {event})	
	
end


local mouseNum = 1
function mouseRun(event)

if (gameIsActive == true) then

	if(EvilMouse.x > -239) then
	EvilMouse.x = EvilMouse.x - (speed/1)
	else
	EvilMouse = display.newImage( myImageSheet , sheetInfo:getFrameIndex("EvilMouse"))
	physics.addBody( EvilMouse, dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, filter=jetCollisionFilter } )
	EvilMouse.isSensor = true
	EvilMouse.name = "EvilMouse"
	EvilMouse.x = 760
	EvilMouse.y = 300
	timer.cancel( event.source )
	mouseNum = mouseNum + 1
	return
	end
	
	tnt:newTimer(1, mouseRun, 1, {event})
end	

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


function updateJet( v )
return function()
	yAxisRandom = math.random (20, 250)
	print ("yAxisRandom:" .. yAxisRandom)
	print ("Find Jet:" .. v)
	if jet[v] == nil then
	print "no jet available"
	else
	jet[v].y = yAxisRandom
	print ("Jet y:" .. jet[v].id .. " " .. jet[v].y)
	end
	timer.performWithDelay(1, jetFlight(v), 1)
end
end

function jetFlight(q)
return function()
--print ("double check y: " .. jet[j].y)
if (gameIsActive == true) then
	if jet[q] == nil then
		print "no jet available 2"
	elseif (jet[q].x > -239) then
		--print ("Jet Flight:" .. jet[j].id .. " " .. jet[j].x)
		jet[q].x = jet[q].x - (speed/.8)
		--print (jet[j].x)
	else
	jet[q].x = 760
	print ("jet reset: ", jet[q].name)
	--timer.cancel(timerIndex[57])
	return
	end	
end
	tnt:newTimer(1, jetFlight(q), 1)
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
	transition.to( TutorialInGame, { time=10000, alpha=0} )
	
	updateBackgrounds()

	tnt:newTimer(7000, ufoFlight, 1)
	tnt:newTimer(9000, updateWarpGate, 1)
	tnt:newTimer(12000, updateJet(1), 1)
	tnt:newTimer(12000, updateJet(2), 1)
	tnt:newTimer(13000, ufoFlight, 1)
	tnt:newTimer(20000, mouseRun, 1)
	tnt:newTimer(21000, updateWarpGate, 1)
	tnt:newTimer(25000, updateJet(3), 1)
	tnt:newTimer(27000, updateJet(1), 1)
	tnt:newTimer(27000, updateJet(2), 1)
	tnt:newTimer(35000, ufoFlight, 1)
	tnt:newTimer(37000, mouseRun, 1)
	tnt:newTimer(45000, updateJet(3), 1)
	tnt:newTimer(48000, updateJet(1), 1)
	tnt:newTimer(49000, updateJet(2), 1)
	tnt:newTimer(51000, mouseRun, 1)
	tnt:newTimer(55000, ufoFlight, 1)
	tnt:newTimer(57000, updateWarpGate, 1)
	tnt:newTimer(60000, endLevel, 1)	
	
end

gameStart()
end


-- Called when scene is about to move offscreen:
function scene:exitScene()

	storyboard.purgeScene()
	Runtime:removeEventListener( "collision", onCollision)
	print( "level1: exitScene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print( "((destroying level1's view))" )
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



