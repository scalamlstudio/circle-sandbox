-- Object

local Object = {}

function Object:new(world, config)
    local object = Config:newObj(config)
    object.world = world
    if object.o == "obst" then
        object.bodytype = "static"
    end
    object.body = love.physics.newBody(Physics, object.x, object.y, object.bodytype)
    object.body:setMass(object.m)
    object.body:setUserData(object)
    if object.o == "proj" then
        local distance = math.sqrt(object.dx ^ 2 + object.dy ^ 2)
        object.body:setLinearVelocity(
            object.s * object.dx / distance,
            object.s * object.dy / distance)
    end
    function object:update(dt)
        if object.o == "play" then
            local dx = love.mouse.getX() - love.graphics.getWidth() / 2
            local dy = love.mouse.getY() - love.graphics.getHeight() / 2
            local distance = math.sqrt(dx ^ 2 + dy ^ 2)
            if love.mouse.isDown(1) then
                dx = object.s * dx / distance
                dy = object.s * dy / distance
                object.body:setLinearVelocity(dx, dy)
                object.x = object.body:getX()
                object.y = object.body:getY()
            end
            if love.keyboard.isDown('q') then
                local conf = {
                    o="proj", x=object.x, y=object.y,
                    dx=dx, dy=dy, r=3, s=600}
                local newobj = Circle:new(object.world, conf)
                object.world:addObj(newobj)
            end
            object.t = 1
            object.body:setPosition(object.x, object.y)
        elseif object.o == "proj" then
            object.x = object.body:getX()
            object.y = object.body:getY()
            object.t = object.t - dt
        elseif object.o == "enem" then
            local char = object.world:findChar()
            local dx = char.x - object.x
            local dy = char.y - object.y
            local distance = math.sqrt(dx ^ 2 + dy ^ 2)
            dx = object.s * dx / distance
            dy = object.s * dy / distance
            object.body:setLinearVelocity(dx, dy)
            object.x = object.body:getX()
            object.y = object.body:getY()
            if object.etype == "range" and math.random() > 0.98 then
                local conf = {
                    o="proj", x=object.x, y=object.y,
                    dx=dx, dy=dy, r=3, s=200}
                local newobj = Triangle:new(object.world, conf)
                object.world:addObj(newobj)
            end
        end
        if (object.o ~= "play" and object.t <= 0) or object.hp <= 0 then
            object.a = false
            object.body:destroy()
        end
    end
    function object:resetPosition()        
        object.body:setPosition(0, 0)
        object.x = 0
        object.y = 0
    end
    return object
end

return Object