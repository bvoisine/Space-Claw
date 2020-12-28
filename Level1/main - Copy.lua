-- Level 1!!!!!!!

-- LOAD PARTICLE LIB
Particles	= require("lib_particle_candy")
local ui = require("ui")

local screenW = display.contentWidth
local screenH = display.contentHeight

local StatusText = display.newText( " ", screenW/2, screenH-20, native.systemFont, 12 )
StatusText:setTextColor( 255,255,255 )

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

local physics = require "physics"
--local scaleFactor = .2
--local physicsData = (require "shapedefs").physicsData(scaleFactor)

physics.start()
physics.setGravity( 0, 0 )


-- Hide Status Bar on iStuff

display.setStatusBar(display.HiddenStatusBar)
system.activate("multitouch")

-- Variables

local cat
local screenText
local score = 0
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
--local isSimulator = "simulator" == system.getInfo("environment")
local gameDisplay = display.newGroup()


	local backgroundMusic = audio.loadStream("Theme.mp3")
	backgroundMusicChannel = audio.play (backgroundMusic, {channel=1, loops=-1, fadein=5000 })
	

	local sheetInfo = require("sprites")
	local myImageSheet = graphics.newImageSheet( "sprites.png", sheetInfo:getSheet() )
	


-- Larger images
	sky = display.newImage("BlueSky.png")
	
	badCloud2 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("BadCloud"))
	badCloud2.x = 300
	badCloud2.y = 30
	badCloud2:scale( 0.25, 0.25 )
	
	badCloud = display.newImage( myImageSheet , sheetInfo:getFrameIndex("BadCloud"))
	badCloud.x = 240
	badCloud.y = 50
	badCloud:scale( 0.40, 0.40 )


	City2 = display.newImage("City2.png")
	City2.x = 780
	
	City = display.newImage("City.png")
	City.x = 240
	

	
	Tree = display.newImage("Tree.png")
	Tree.y = 240
	Tree.x = 220

	Tree2 = display.newImage("Tree2.png")
	Tree2.y = 240
	Tree2.x = 760
	
	Tree3 = display.newImage("Tree2.png")
	Tree3.y = 200
	Tree3.x = 300
	

	
	Tree1 = display.newImage("Tree.png")
	Tree1.y = 190
	Tree1.x = 460

	Tree:scale( 0.25, 0.25 )	
	Tree1:scale( 0.30, 0.40 )	
	Tree2:scale( 0.25, 0.25 )	
	Tree3:scale( 0.35, 0.350 )	
	House = display.newImage("House.png")
	House.x = 240

jet = {}
	
-- Create Jets
for a = 1, 3 do
	jet[a] = display.newImage( myImageSheet , sheetInfo:getFrameIndex("ComPlane"))
	jet[a].x = 760
	jet[a].collision = onLocalCollision
	jet[a].radius = 0.15
	jetCollisionFilter = { categoryBits = 2, maskBits = 9 }
	physics.addBody( jet[a], dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, filter=jetCollisionFilter } )
	--jet[a].rotation = 10.0
    jet[a].name = ("jet" .. a)
    jet[a].id = (a)
	jet[a].isSensor = true
	--print (jet[a].id .. " created")
	--print ("Hello: " .. jet[a].name)
end




	ufo = display.newImage( myImageSheet , sheetInfo:getFrameIndex("BadShip"))
	ufo.x = 760
	ufo.name = "ufo"
	physics.addBody( ufo, dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, filter=jetCollisionFilter } )
	ufo.isSensor = true

	
	local ufoFlag = 0
	
	
	-- Cat
	
local sequenceData = {
	name="flying",
    frames = { 14, 15, 16, 17, 16, 15 },
    --count=6,
    time=700,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
    loopCount = 0    -- Optional. Default is 0 (loop indefinitely)
    --loopDirection = "forward"    -- Optional. Values include: "forward","bounce"
}	

local sequenceData2 = {
	name="weaponBlast",
    frames = { 22, 23, 24, 25, 24, 25 },
    --count=6,
    time=700,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
    loopCount = 3
    --loopDirection = "forward"    -- Optional. Values include: "forward","bounce"
}	


local sequenceData3 = {
	name="warping",
    frames = { 2, 3 },
    --count=6,
    time=700,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
    loopCount = 3
    --loopDirection = "forward"    -- Optional. Values include: "forward","bounce"
}

	
	cat = display.newSprite( myImageSheet, sequenceData )	
	--cat:scale( 0.15, 0.15 )
	cat.x = 80
	cat.y = 100
	cat.name = "cat"
	cat.collision = onLocalCollision
	--physics.addBody(cat, "dynamic", physicsData:get("sprites"))
	--physics.addBody( cat, "static", physicsData:get("sprites") )
	local catCollisionFilter = { categoryBits = 1, maskBits = 6 }
	physics.addBody( cat, dynamic, { density=1, friction=0, bounce=0, radius=.01, filter=catCollisionFiler } )
	cat.rotation = 0
	cat.isSensor = true
	cat:play()
	
	local EvilMouse = display.newImage( myImageSheet , sheetInfo:getFrameIndex("EvilMouse"))
	physics.addBody( EvilMouse, dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, filter=jetCollisionFilter } )
	EvilMouse.isSensor = true
	EvilMouse.name = "EvilMouse"
	EvilMouse.x = 760
	EvilMouse.y = 300
	
	Grass = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Grass"))
	Grass.y = 315
	Grass.x = 240
	
	Grass2 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Grass"))
	Grass2.y = 315
	Grass2.x = 240
	--physics.addBody( Grass2, "static", physicsData:get("Grass") )
	
	Grass3 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("Grass"))
	Grass3.y = 316
	Grass3.x = 760
	
	local j = 1
	

	
	local pauseBtn = display.newImage( myImageSheet , sheetInfo:getFrameIndex("pauseBtn"))
	pauseBtn.x = 460
	pauseBtn.y = 25

	
	local weaponBtn = display.newImage( myImageSheet , sheetInfo:getFrameIndex("specialBtn"))
	weaponBtn.x = 440
	weaponBtn.y = 280
	weaponBtn:scale(.75, .75)
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

	
function main()	

	pauseListener("add")

if (gameIsActive == true) then
	updateBackgrounds()
	gameListeners("add")
	screenText = display.newText("Zing: " .. score, 20, 0, "Arial", 12)
	--timer.performWithDelay(5000, warpGate, 1)
	timer.performWithDelay(10000, mouseRun, 1)
	timer.performWithDelay(15000, ufoFlight, 1)
	timer.performWithDelay(30000, updateJet, 1)
	timer.performWithDelay(35000, ufoFlight, 1)
	timer.performWithDelay(45000, mouseRun, 1)
	timer.performWithDelay(50000, updateJet, 1)
	timer.performWithDelay(600000, ufoFlight, 1)
	--timer.performWithDelay(1000, warpGateMove, 1)
end	
	
end



function onCollision( event )


		objectName = tostring(event.object1.name)
		
		local caty = cat.y
		local catx = cat.x

        if ( event.phase == "began" ) then

				
				if ((event.object2.name == "weaponBlast" and event.object1.name == jet[j].name) or (event.object1.name == "weaponBlast" and event.object2.name == jet[j].name)) then
				print ("move jet")
				dangerousJet = false
				score = score + 200
				screenText.text = ("Zing: " .. score)
				timer.performWithDelay( 1, explodeJet(), 1)	
				end
				
				--[[
				if (event.object1.name == jet[j].name and event.object2.name == "cat" and dangerousJet == true) then
				print ("dead cat from " .. jet[j].name)
				cat:removeSelf()
				Runtime:removeEventListener("touch", screenTouched)
				cat = display.newImage( myImageSheet , sheetInfo:getFrameIndex("catrightDead"))
				cat.y = caty
				cat.x = catx
				timer.performWithDelay( 1, catDie(), 1)	
				end--]]
				
				
				if (event.object1.name == "ufo" and event.object2.name == "cat") then
				print ("dead cat from ufo")
				end
				
				
				if ((event.object2.name == "weaponBlast" and event.object1.name == "ufo") or (event.object1.name == "weaponBlast" and event.object2.name == "ufo")) then
				print ("explode ufo")
				score = score + 100
				screenText.text = ("Zing: " .. score)
				Particles.StartEmitter("E1")
				timer.performWithDelay( 1, explodeUFO(), 1)			
				end
				
				
				if ((event.object2.name == "weaponBlast" and event.object1.name == "EvilMouse") or (event.object1.name == "weaponBlast" and event.object2.name == "EvilMouse")) then
				print ("destroy mouse")
				score = score + 500
				screenText.text = ("Zing: " .. score)
				timer.performWithDelay( 1, destroyMouse(), 1)			
				end

				
                print( "Contact began: " .. event.object1.name .. " & " .. event.object2.name )
				--main()
 
        elseif ( event.phase == "ended" ) then
 
                --print( "ended: " .. event.object1.name .. " & " .. event.object2.name )
				 
        end


end

function destroyMouse(event)
		if (gameIsActive == true) then	
		EvilMouse:removeSelf()
		EvilMouse = display.newImage("smoke.png")
		EvilMouse.x = 300
		EvilMouse.y = 300
		end
		
--timer.performWithDelay( 33, destroyMouse, 1 )
end



function catDie(event)

	if (cat.y < 400) then
	cat.y = cat.y + 10
	else
	print ("restart level")
	return
	end
	

		timer.performWithDelay( 1, catDie, 1 )
end



function explodeUFO(event)
		if (gameIsActive == true) then										
				-- TRIGGER THE EMITTERS
				
				if(ufo.x > -800) then
				Emitter1.x = ufo.x
				Emitter1.y = ufo.y
				timer.performWithDelay(1, function() ufo.y = ufo.y + 5 end, 1)
				Particles.Update()
				else
				print "all done!!!!!!!!!!!!!!!!!!"
				timer.cancel( event.source )
				return
				end
				
				
		end
		
		timer.performWithDelay( 33, explodeUFO, 1 )
end


function explodeJet(event)
		if (gameIsActive == true) then
												
				-- TRIGGER THE EMITTERS
				
				if(jet[j].x > -200) then
				timer.performWithDelay(1, function() jet[j].y = jet[j].y -10 end, 1)
				Particles.Update()
				else
				dangerousJet = true
				print "all done!!!!!!!!!!!!!!!!!!"
				timer.cancel( event.source )
				return
				end
				

		end	
	timer.performWithDelay( 1, explodeJet, 1 )
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

timer.performWithDelay(100, stayCat, 11)
weaponBtn:removeEventListener("touch", weaponTouched)
end
end

function stayCat()

--print(iter)

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


function specialTouched(event)


print "Special Button Touched"


end

function pauseTouched(event)

local gameStatus = tostring(gameIsActive)

print ("pause touched")
if (gameIsActive == true) then
	gameIsActive = false
	cat:pause()
	pauseBtn:removeSelf()
	pauseBtn = display.newImage( myImageSheet , sheetInfo:getFrameIndex("playGameBtn"))
	pauseBtn.x = 460
	pauseBtn.y = 25
	pauseBtn:addEventListener("tap", pauseTouched)
	weaponBtn:removeEventListener("tap", weaponTouched)
	pauseInfo = display.newRoundedRect(30, 50, 400, 260, 12)
	pauseInfo.strokeWidth = 3
	pauseInfo:setFillColor(blue)
	pauseInfo.alpha = 0.90
	local pauseText = display.newText("Game Pause...", 35, 55, "Arial", 12)
	-------------------------------------------------------------
	-- Event for music on/off
	-------------------------------------------------------------	
	local onMusicTouch = function( event )
		if event.phase == "release" then
			
			if (gameSettings[1] == "true") then
				gameSettings[1] = "false"
				music = "false"
				print "music button touched, now 1"
				musicBtn:removeSelf()
				musicBtn = nil
				musicStatus()
				audio.pause( 1 )
			else
				gameSettings[1] = "true"
				music = "true"
				print "music button touched, now 0"
				musicBtn:removeSelf()
				musicBtn = nil
				musicStatus()
				local tryResume = audio.resume( 1 )
				print ( tryResume )
			end
			
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
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	print "check me!"
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
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	print "other one!"
	end
	
	musicBtn.x = 70; musicBtn.y = 160
	end
	print (gameStatus)
else 
	gameIsActive = true
	cat:play()
	pauseBtn:removeSelf()
	pauseBtn = display.newImage( myImageSheet , sheetInfo:getFrameIndex("pauseBtn"))
	pauseBtn.x = 460
	pauseBtn.y = 25
	pauseBtn:addEventListener("tap", pauseTouched)
	weaponBtn:addEventListener("tap", weaponTouched)
	print (gameStatus)
end

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
timer.performWithDelay(1, updateBackgrounds, 1)
end


function ufoFlight(event)

if (gameIsActive == true) then
	if(ufo.x < -810) then
	ufo.x = 760
	ufo.y = 0
	Particles.StopEmitter("E1")
	timer.cancel( event.source )
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
	timer.performWithDelay(10, ufoFlight, 1)
	
end

function mouseRun(event)

if (gameIsActive == true) then
	EvilMouse.x = EvilMouse.x - (speed/1)

	if(EvilMouse.x < -239) then
	EvilMouse = display.newImage( myImageSheet , sheetInfo:getFrameIndex("EvilMouse"))
	physics.addBody( EvilMouse, dynamic, { density=1, friction=0, bounce=15.0, radius=jet.radius, filter=jetCollisionFilter } )
	EvilMouse.isSensor = true
	EvilMouse.name = "EvilMouse"
	EvilMouse.x = 760
	EvilMouse.y = 300
	return
	end
end	
	timer.performWithDelay(1, mouseRun, 1)
end

function updateJet( event )

if (gameIsActive == true) then	
	yAxisRandom = math.random (20, 180)
	print ("yAxisRandom:" .. yAxisRandom)
	print ("Find Jet:" .. j)
	if jet[j] == nil then
	print "no jet available"
	else
	jet[j].y = yAxisRandom
	print ("Jet y:" .. jet[j].id .. " " .. jet[j].y)
	jetFlight()
	end
end
	
end

function jetFlight()

--print ("double check y: " .. jet[j].y)
if (gameIsActive == true) then
	if jet[j] == nil then
		print "no jet available 2"
	elseif (jet[j].x > -239) then
		--print ("Jet Flight:" .. jet[j].id .. " " .. jet[j].x)
		jet[j].x = jet[j].x - (speed/.8)
		--print (jet[j].x)
	else
	jet[j].x = 760
		if (j < 3) then
			j = j + 1
			print ("j is: " .. j)
		else
			j = 1
			print ("j is reset: " .. j)
		end
	return
	end	
end
	timer.performWithDelay(1, jetFlight, 1)

end



function gameListeners(event)
	if event == "add" then
		--Runtime:addEventListener("accelerometer", moveCat)
		-- cat:addEventListener("collision", bounce)
		-- Used to drag the cat on the simulator
		--cat:addEventListener("touch", dragCat)
		--cat:addEventListener( "collision", cat )
		--jet:addEventListener( "collision", jet )
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

function warpGateMove(event)

if (warpGate.x > -239) then
		warpGate.x = warpGate.x - (speed/4)
end		

if (warpGate.x < 110) then

warpGate:play()

end
	timer.performWithDelay(1, warpGateMove, 1)
end

main()