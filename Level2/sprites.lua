--
-- created with TexturePacker (http://www.texturepacker.com)
--
-- $TexturePacker:SmartUpdate:e3068d0bc2a517c768098c09ad7962f0$
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
            x=2,
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
            x=204,
            y=18,
            width=170,
            height=64,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 170,
            sourceHeight = 71
        },
        {
            -- ComPlane
            x=154,
            y=270,
            width=150,
            height=96,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 150,
            sourceHeight = 100
        },
        {
            -- EvilMouse
            x=228,
            y=368,
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
            -- catrightDead
            x=204,
            y=84,
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
            y=92,
            width=158,
            height=72,

            sourceX = 2,
            sourceY = 6,
            sourceWidth = 160,
            sourceHeight = 107
        },
        {
            -- catrightOrange2
            x=162,
            y=204,
            width=158,
            height=64,

            sourceX = 2,
            sourceY = 14,
            sourceWidth = 160,
            sourceHeight = 107
        },
        {
            -- catrightOrange3
            x=162,
            y=136,
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
            y=166,
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
            x=478,
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
            x=376,
            y=18,
            width=100,
            height=98,

            sourceX = 46,
            sourceY = 44,
            sourceWidth = 200,
            sourceHeight = 200
        },
        {
            -- warpGateZing
            x=172,
            y=368,
            width=54,
            height=130,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 122,
            sourceHeight = 130
        },
        {
            -- weaponBlast1
            x=100,
            y=382,
            width=70,
            height=102,

            sourceX = 0,
            sourceY = 12,
            sourceWidth = 150,
            sourceHeight = 148
        },
        {
            -- weaponBlast2
            x=2,
            y=382,
            width=96,
            height=104,

            sourceX = 0,
            sourceY = 14,
            sourceWidth = 150,
            sourceHeight = 148
        },
        {
            -- weaponBlast3
            x=366,
            y=118,
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
            y=232,
            width=150,
            height=148,

        },
        {
            -- weaponBtn
            x=162,
            y=92,
            width=40,
            height=40,

        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["BadCloud"] = 1,
    ["BadShip"] = 2,
    ["ComPlane"] = 3,
    ["EvilMouse"] = 4,
    ["Grass"] = 5,
    ["catrightDead"] = 6,
    ["catrightOrange1"] = 7,
    ["catrightOrange2"] = 8,
    ["catrightOrange3"] = 9,
    ["catrightOrange4"] = 10,
    ["pauseBtn"] = 11,
    ["playGameBtn"] = 12,
    ["specialBtn"] = 13,
    ["warpGateZing"] = 14,
    ["weaponBlast1"] = 15,
    ["weaponBlast2"] = 16,
    ["weaponBlast3"] = 17,
    ["weaponBlast4"] = 18,
    ["weaponBtn"] = 19,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
