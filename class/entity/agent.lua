-- Agent

local Agent = {}
local agentmap = {}
agentmap[1] = {t=1.427e8}
function Agent:get(world, conf)
    local newconf = agentmap[conf['id']] or agentmap[1]
    newconf.o = "play"
    newconf.alias = 1
    for k, v in pairs(newconf) do
        conf[k] = v
    end
    local object = Circle:new(world, conf)
    function object:update(dt)
        local dx = love.mouse.getX() - love.graphics.getWidth() / 2
        local dy = love.mouse.getY() - love.graphics.getHeight() / 2
        local distance = math.sqrt(dx ^ 2 + dy ^ 2)
        if love.mouse.isDown(1) then
            dx = object.s * dx / distance
            dy = object.s * dy / distance
            object.body:setLinearVelocity(dx, dy)
        else
            object.body:setLinearVelocity(0, 0)
        end
        object.x = object.body:getX()
        object.y = object.body:getY()
        if love.keyboard.isDown('q') then
            local conf = {id=1, alias=1, x=object.x, y=object.y, dx=dx, dy=dy}
            local newobj = Projectile:get(object.world, conf)
            object.world:addObj(newobj)
        end
        object.t = 1 -- NOT CLEARED BY WORLD
    end
    function object:handle(event)
        if event.etype == "hit" then
            if event.object.alias == 2 then
                object.hp = object.hp - 1
                object.world.log:add("Agent Got Hit HP:" .. tostring(object.hp))
            end
        end
    end
    return object
end

return Agent