-- World

local World = {}

function World:new(config)
    local world = config or {}
    world.w = love.graphics.getWidth()
    world.h = love.graphics.getHeight()
    world.objs = world.objs or {}
    function world:update(dt, paras)
        circle = world.objs[1]
        world.w = love.graphics.getWidth()
        world.h = love.graphics.getHeight()

        local objsize = #world.objs
        for i = 1, objsize do
            world.objs[i]:update(dt)
        end

        -- if love.math.random() < 0.1 then
        --     local dx = math.random(-1000, 1000)
        --     local dy = math.random(-1000, 1000)
        --     local sconf = {x=circle.x-dx, y=circle.y-dy, vx=dx, vy=dy}
        --     local newobj = Square:new(world, sconf)
        --     world:addObj(newobj)
        -- end

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
    function world:draw()
        for i = 1, #world.objs do
            world.objs[i]:draw()
        end
    end
    return world
end

return World