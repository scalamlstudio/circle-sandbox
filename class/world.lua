-- World

local World = {}

function World:new(config)
    local world = config or {}
    world.w = love.graphics.getWidth()
    world.h = love.graphics.getHeight()
    world.objs = world.objs or {}
    world.char = world.char or nil
    function world:update(dt, paras)
        world.w = love.graphics.getWidth()
        world.h = love.graphics.getHeight()

        local objsize = #world.objs
        for i = 1, objsize do
            world.objs[i]:update(dt)
        end

        local newobjs = {}
        for i = 1, #world.objs do
            if world.objs[i].a then
                table.insert(newobjs, world.objs[i])
            end
        end
        world.objs = newobjs
    end
    function world:addObj(obj)
        table.insert(world.objs, obj)
    end
    function world:clear()
        for i = 1, #world.objs do
            world.objs[i].t = 0
        end
    end
    function world:findChar()
        if world.char == nil then
            for i = 1, #world.objs do
                if world.objs[i].o == "play" then
                    world.char = world.objs[i]
                end
            end
        end
        return world.char
    end
    function world:initLevel()
        -- target
        local nx = love.math.random(-200, 200)
        local ny = love.math.random(-200, 200)
        local conf = {o="obst",x=nx, y=ny, r=100, t=300, hp=1.427e8, alias=4}
        local obj = Square:new(world, conf)
        table.insert(world.objs, obj)
        -- obstables
        for i = 1, 100 do
            local nx = love.math.random(-1000, 1000)
            local ny = love.math.random(-1000, 1000)
            if nx^2 + ny^2 > 100000 then
                local conf = {o="obst",x=nx, y=ny, r=200, hp=10, t=1.427e8}
                local obj = Square:new(world, conf)
                table.insert(world.objs, obj)
            end
        end
        -- enemies
        for i = 1, 10 do
            local nx = love.math.random(-1000, 1000)
            local ny = love.math.random(-1000, 1000)
            if nx^2 + ny^2 > 1000 then
                local conf = {o="enem",x=nx, y=ny, s=100, r=8, hp=10, t=1.427e8}
                local obj = Triangle:new(world, conf)
                table.insert(world.objs, obj)
            end
        end
        -- enemies range
        for i = 1, 5 do
            local nx = love.math.random(-1000, 1000)
            local ny = love.math.random(-1000, 1000)
            if nx^2 + ny^2 > 1000 then
                local conf = {o="enem",x=nx, y=ny, s=100, r=12, etype="range", hp=20, t=1.427e8}
                local obj = Triangle:new(world, conf)
                table.insert(world.objs, obj)
            end
        end
    end
    function world:draw()
        for i = 1, #world.objs do
            world.objs[i]:draw()
        end
    end
    return world
end

return World