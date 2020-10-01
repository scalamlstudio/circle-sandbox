-- Main
require("requirement")

-- Init Player
local player = love.filesystem.getInfo('player')
if player == nil then
    -- Create First Character
    player = Player:new("Wei-Player")
    player:addChar(Char:new("Wei-Char"))
end
-- Load World
local StartTime = math.floor(love.timer.getTime())
local panel = Panel:new(10, 10)
local log = Panel:new(600, 10)
local world = {}
local agent = {}
local keys = {}

function love.load()
    love.window.setTitle("CIRCLE")
    love.graphics.setBackgroundColor(0, 0, 0)
    -- Init World
    Physics:load()
    Shader:load()
    world = World:new({id=2, log=log, keys=keys})
    world:initLevel()
    -- Select Char
    agent = Agent:get(world, player.chars[1])
    world:addObj(agent)
end

function love.update(dt)
    -- Check Keys
    for key, keytime in pairs(keys) do
        if not love.keyboard.isDown(key) then
            keys[key] = nil
        end
    end
    -- Switch World
    if world.port > 0 then
        world:clear()
        world.id = world.port
        world.port = 0
        world:initLevel()
        agent:resetPosition()
        Camera:setObj(world, agent)
    end
    -- Update World and Physics
    world:update(dt)
    Physics:update(dt)
    -- Update Panel
    panel:update("Time:" .. tostring(math.floor(love.timer.getTime()) - StartTime) .. "  FPS:" .. tostring(love.timer.getFPS()))
    panel:add("Window - W:" .. tostring(world.w) .. "  H:" .. tostring(world.h) .. "  DT:" .. tostring(dt))
    panel:add("Circle - X:" .. tostring(agent.x) .. "  Y:" .. tostring(agent.y) .. "  HP:" .. tostring(agent.hp))
    panel:add("Obj Count:" .. tostring(#world.objs))
    -- Update Log
    log:trim()
    for n, a, b, c, d, e, f in love.event.poll() do
        log:add("Event: " .. n .. " " .. tostring(a))
    end
    -- Update Camera
    Camera:follow(world, agent)
    Camera:update(dt)
end

function love.draw()
    -- Shader on Camera to World
    Shader:set({screen={world.w, world.h}})
    Camera:set()
    world:draw()
    Camera:unset()
    Shader:unset()
    -- Draw Panel
    panel:draw()
    log:draw()
end
-- Control Key
function love.keypressed(key, scancode, isrepeat)
    keys[key] = love.timer.getTime()
    if key == "escape" then love.event.quit() end
end