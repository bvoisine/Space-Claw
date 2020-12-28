--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:7b3256fbfd0b1580aa3a665e55cc2a99$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- BadCloud
            x=278,
            y=18,
            width=200,
            height=72,

            sourceX = 0,
            sourceY = 26,
            sourceWidth = 200,
            sourceHeight = 133
        },
        {
            -- BadShip
            x=278,
            y=92,
            width=170,
            height=64,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 170,
            sourceHeight = 71
        },
        {
            -- EvilMouse
            x=430,
            y=600,
            width=68,
            height=28,

            sourceX = 4,
            sourceY = 8,
            sourceWidth = 75,
            sourceHeight = 50
        },
        {
            -- Grass
            x=2,
            y=2,
            width=480,
            height=14,

        },
        {
            -- Tree
            x=278,
            y=158,
            width=168,
            height=198,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 200,
            sourceHeight = 200
        },
        {
            -- Tree2
            x=2,
            y=18,
            width=274,
            height=164,

            sourceX = 0,
            sourceY = 36,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- alien
            x=164,
            y=184,
            width=110,
            height=54,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 110,
            sourceHeight = 53
        },
        {
            -- beam
            x=470,
            y=630,
            width=38,
            height=212,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 37,
            sourceHeight = 211
        },
        {
            -- beam2
            x=430,
            y=630,
            width=38,
            height=212,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 37,
            sourceHeight = 211
        },
        {
            -- beam3
            x=390,
            y=424,
            width=38,
            height=212,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 37,
            sourceHeight = 211
        },
        {
            -- bunny
            x=162,
            y=340,
            width=100,
            height=50,

        },
        {
            -- catrightDead
            x=2,
            y=184,
            width=160,
            height=50,

            sourceX = 0,
            sourceY = 26,
            sourceWidth = 160,
            sourceHeight = 107
        },
        {
            -- catrightOrange1
            x=2,
            y=236,
            width=158,
            height=72,

            sourceX = 2,
            sourceY = 6,
            sourceWidth = 160,
            sourceHeight = 107
        },
        {
            -- catrightOrange2
            x=264,
            y=358,
            width=158,
            height=64,

            sourceX = 2,
            sourceY = 14,
            sourceWidth = 160,
            sourceHeight = 107
        },
        {
            -- catrightOrange3
            x=2,
            y=310,
            width=158,
            height=66,

            sourceX = 2,
            sourceY = 12,
            sourceWidth = 160,
            sourceHeight = 107
        },
        {
            -- catrightOrange4
            x=2,
            y=378,
            width=158,
            height=64,

            sourceX = 2,
            sourceY = 12,
            sourceWidth = 160,
            sourceHeight = 107
        },
        {
            -- frog
            x=154,
            y=498,
            width=90,
            height=62,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 90,
            sourceHeight = 61
        },
        {
            -- jbeam
            x=448,
            y=282,
            width=38,
            height=212,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 37,
            sourceHeight = 211
        },
        {
            -- jet
            x=260,
            y=424,
            width=128,
            height=32,

        },
        {
            -- laser
            x=448,
            y=224,
            width=50,
            height=14,

        },
        {
            -- missle
            x=154,
            y=562,
            width=88,
            height=18,

        },
        {
            -- pauseBtn
            x=484,
            y=2,
            width=18,
            height=26,

            sourceX = 6,
            sourceY = 2,
            sourceWidth = 30,
            sourceHeight = 30
        },
        {
            -- playGameBtn
            x=480,
            y=30,
            width=28,
            height=30,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 30,
            sourceHeight = 30
        },
        {
            -- specialBtn
            x=162,
            y=240,
            width=100,
            height=98,

            sourceX = 46,
            sourceY = 44,
            sourceWidth = 200,
            sourceHeight = 200
        },
        {
            -- warpGateZing
            x=450,
            y=92,
            width=54,
            height=130,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 122,
            sourceHeight = 130
        },
        {
            -- weaponBlast1
            x=430,
            y=496,
            width=70,
            height=102,

            sourceX = 0,
            sourceY = 12,
            sourceWidth = 150,
            sourceHeight = 148
        },
        {
            -- weaponBlast2
            x=162,
            y=392,
            width=96,
            height=104,

            sourceX = 0,
            sourceY = 14,
            sourceWidth = 150,
            sourceHeight = 148
        },
        {
            -- weaponBlast3
            x=260,
            y=458,
            width=116,
            height=116,

            sourceX = 0,
            sourceY = 12,
            sourceWidth = 150,
            sourceHeight = 148
        },
        {
            -- weaponBlast4
            x=2,
            y=444,
            width=150,
            height=148,

        },
        {
            -- weaponBtn
            x=448,
            y=240,
            width=40,
            height=40,

        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["BadCloud"] = 1,
    ["BadShip"] = 2,
    ["EvilMouse"] = 3,
    ["Grass"] = 4,
    ["Tree"] = 5,
    ["Tree2"] = 6,
    ["alien"] = 7,
    ["beam"] = 8,
    ["beam2"] = 9,
    ["beam3"] = 10,
    ["bunny"] = 11,
    ["catrightDead"] = 12,
    ["catrightOrange1"] = 13,
    ["catrightOrange2"] = 14,
    ["catrightOrange3"] = 15,
    ["catrightOrange4"] = 16,
    ["frog"] = 17,
    ["jbeam"] = 18,
    ["jet"] = 19,
    ["laser"] = 20,
    ["missle"] = 21,
    ["pauseBtn"] = 22,
    ["playGameBtn"] = 23,
    ["specialBtn"] = 24,
    ["warpGateZing"] = 25,
    ["weaponBlast1"] = 26,
    ["weaponBlast2"] = 27,
    ["weaponBlast3"] = 28,
    ["weaponBlast4"] = 29,
    ["weaponBtn"] = 30,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
