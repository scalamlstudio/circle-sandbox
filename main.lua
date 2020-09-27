-- -- Main
require("requirement")

-- Init Player
local player = love.filesystem.getInfo('player')
if player == nil then
    player = Player:new("Wei-Player")
    player:addChar(Char:new("Wei-Char"))
end

-- Load World
local StartTime = math.floor(love.timer.getTime())
local panel = Panel:new(10, 10)
local log = Panel:new(10, 100)
local world = World:new({id=2, log=log})
local agent = {}

function love.load()
    love.window.setTitle("CIRCLE")
    love.graphics.setBackgroundColor(0, 0, 0)

    Physics:load()
    Shader:load()
    world:initLevel()
    -- Select Char
    agent = Agent:get(world, player.chars[1])
    world:addObj(agent)

    Restart = false
end

function love.update(dt)
    if Restart then
        Restart = false
        agent:resetPosition()
        world:clear()
        world.id = love.math.random(1, 2)
        world:initLevel()
        -- world:addObj(agent)
        Camera:setObj(world, agent)
    end
    world:update(dt)
    Physics:update(dt)

    panel:update("Time:" .. tostring(math.floor(love.timer.getTime()) - StartTime) .. "  FPS:" .. tostring(love.timer.getFPS()))
    panel:add("Window - W:" .. tostring(world.w) .. "  H:" .. tostring(world.h))
    panel:add("Circle - X:" .. tostring(agent.x) .. "  Y:" .. tostring(agent.y) .. "  HP:" .. tostring(agent.hp))
    panel:add("Obj Count:" .. tostring(#world.objs))
    log:trim()

    Camera:follow(world, agent)
    Camera:update(dt)
end

function love.draw()
    Shader:set({screen={world.w, world.h}})
    Camera:set()
    world:draw()
    Camera:unset()
    Shader:unset()
    panel:draw()
    log:draw()
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
end