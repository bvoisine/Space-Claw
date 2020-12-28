--
-- created with TexturePacker (http://www.texturepacker.com)
--
-- $TexturePacker:SmartUpdate:5eea76069a8beea1a97da4fe5c7cc453$
--
-- local sheetInfo = require("myExportedImageSheet") -- lua file that Texture packer published
--
-- local myImageSheet = graphics.newImageSheet( "ImageSheet.png", sheetInfo:getSheet() ) -- ImageSheet.png is the image Texture packer published
--
-- local myImage1 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("image_name1"))
-- local myImage2 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("image_name2"))
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
            -- ComPlane
            x=2,
            y=444,
            width=150,
            height=96,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 150,
            sourceHeight = 100
        },
        {
            -- EvilMouse
            x=162,
            y=390,
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
            x=260,
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
            x=164,
            y=184,
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
            x=420,
            y=358,
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
            y=284,
            width=96,
            height=104,

            sourceX = 0,
            sourceY = 14,
            sourceWidth = 150,
            sourceHeight = 148
        },
        {
            -- weaponBlast3
            x=2,
            y=542,
            width=116,
            height=116,

            sourceX = 0,
            sourceY = 12,
            sourceWidth = 150,
            sourceHeight = 148
        },
        {
            -- weaponBlast4
            x=162,
            y=424,
            width=150,
            height=148,

        },
        {
            -- weaponBtn
            x=448,
            y=224,
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
    ["ComPlane"] = 3,
    ["EvilMouse"] = 4,
    ["Grass"] = 5,
    ["Tree"] = 6,
    ["Tree2"] = 7,
    ["catrightDead"] = 8,
    ["catrightOrange1"] = 9,
    ["catrightOrange2"] = 10,
    ["catrightOrange3"] = 11,
    ["catrightOrange4"] = 12,
    ["pauseBtn"] = 13,
    ["playGameBtn"] = 14,
    ["specialBtn"] = 15,
    ["warpGateZing"] = 16,
    ["weaponBlast1"] = 17,
    ["weaponBlast2"] = 18,
    ["weaponBlast3"] = 19,
    ["weaponBlast4"] = 20,
    ["weaponBtn"] = 21,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
