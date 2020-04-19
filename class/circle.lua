-- Circle

local Circle = {}

function Circle:new(world)
    local circle = {}
    circle.a = true
    circle.x = circle.x or 0
    circle.y = circle.y or 0
    function circle:update(dt)
        local dx = love.mouse.getX() - love.graphics.getWidth() / 2
        local dy = love.mouse.getY() - love.graphics.getHeight() / 2
        local distance = math.sqrt(dx ^ 2 + dy ^ 2)
        local speed = 300 * dt
        if love.mouse.isDown(1) then
            if distance > speed then
                dx = dx * speed / distance
                dy = dy * speed / distance
            end
            circle.x = circle.x + dx
            circle.y = circle.y + dy
        end
        if love.keyboard.isDown('q') then
            local sconf = {x=circle.x, y=circle.y, vx=dx, vy=dy}
            local newobj = Square:new(world, sconf)
            world:addObj(newobj)
        end
    end
    function circle:draw()
        love.graphics.setColor(0.9, 0.9, 0.9)
        love.graphics.circle("fill", circle.x, circle.y, 10, 20)
    end
    return circle
end

return Circle