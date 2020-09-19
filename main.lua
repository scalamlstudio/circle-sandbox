-- Main

Camera = require("general/camera")
Panel = require("general/panel")

Physics = love.physics.newWorld(0, 0, true)
World = require("class/world")
Player = require("class/player")
Enemy = require("class/enemy")
Char = require("class/char")
Config = require("class/config")
Object = require("class/object")
Circle = require("class/circle")
Square = require("class/square")
Triangle = require("class/triangle")

-- Init Player
local player = love.filesystem.getInfo('player')
if player == nil then
    player = Player:new("Wei-Player")
    player:addChar(Char:new("Wei-Char"))
end

-- Load World
local StartTime = math.floor(love.timer.getTime() * 10)
local panel = Panel:new("Time: 0", 10, 10)
local world = World:new()
local char = {}

function love.load()
    love.window.setTitle("TEST")
    love.graphics.setBackgroundColor(0, 0, 0)

    Physics:setCallbacks(beginContact, endContact, preSolve, postSolve)
    world:initLevel()
    -- Select Char
    char = Circle:new(world, player.chars[1])
    world:addObj(char)

    Restart = false
    text = ""
    persisting = 0
end

function love.update(dt)
    if Restart then
        Restart = false
        char:resetPosition()
        world:clear()
        world:initLevel()
    end
    world:update(dt)
    Physics:update(dt)

    panel:update("Time:" .. tostring((math.floor(love.timer.getTime() * 10) - StartTime) / 10.0) ..
        "  FPS:" .. tostring(love.timer.getFPS()))
    panel:add("Window - W:" .. tostring(world.w) ..
        "  H:" .. tostring(world.h))
    panel:add("Circle - X:" .. tostring(char.x) ..
        "  Y:" .. tostring(char.y))
    panel:add("Obj Count:" .. tostring(#world.objs))

    Camera:follow(world, char)
    Camera:update(dt)

    if string.len(text) > 768 then    -- cleanup when 'text' gets too long
        text = ""
    end
end

function love.draw()
    Camera:set()
    world:draw()
    Camera:unset()
    panel:draw()

    love.graphics.print(text, 10, 100)
end

----

function beginContact(a, b, coll)
    x, y = coll:getNormal()
    local aobj = a:getBody():getUserData()
    local bobj = b:getBody():getUserData()
    text = text.."\n"..aobj.o..
        " colliding with "..bobj.o..
        " with a vector normal of: "..x..", "..y
    if aobj.o == "proj" or bobj.o == "proj" then
        aobj.hp = aobj.hp - 1
        bobj.hp = bobj.hp - 1
    end
    if aobj.alias == 4 and bobj.o == "play" then
        Restart = true
    end
end

function endContact(a, b, coll)
    persisting = 0
end

function preSolve(a, b, coll)
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end
