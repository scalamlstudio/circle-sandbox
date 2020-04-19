-- Main

Camera = require("general/camera")
Panel = require("general/panel")

Player = require("class/player")
Char = require("class/Char")
World = require("class/world")
Circle = require("class/circle")
Square = require("class/square")

-- Init Player
local player = love.filesystem.getInfo('player')
if player == nil then
    player = Player:new("Wei-Player")
end

-- Select Char / Create Char / Delete Char

player:addChar(Char:new("Wei-Char"))

-- Load World

local StartTime = math.floor(love.timer.getTime() * 10)
local panel = Panel:new("Time: 0", 10, 10)
local world = World:new()
local circle = Circle:new(world)
world:addObj(circle)

function love.load()
    love.window.setTitle("TEST")
    love.graphics.setBackgroundColor(0, 0, 0)
end

function love.update(dt)
    local stats = world:update(dt)

    panel:update("Time:" .. tostring((math.floor(love.timer.getTime() * 10) - StartTime) / 10.0) ..
        "  FPS:" .. tostring(love.timer.getFPS()))
    panel:add("Window - W:" .. tostring(world.w) ..
        "  H:" .. tostring(world.h))
    panel:add("Circle - X:" .. tostring(circle.x) ..
        "  Y:" .. tostring(circle.y))
    panel:add("Obj Count:" .. tostring(#world.objs))
    -- panel:add(tostring(player))

    Camera:follow(world, circle)
    Camera:update(dt)
end

function love.draw()
    Camera:set()
    world:draw()
    Camera:unset()
    panel:draw()
end
