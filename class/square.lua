-- Square

local Square = {}

function Square:new(world, config)
    local square = config
    square.a = true
    square.t = 0
    square.s = square.s or 600
    function square:update(dt)
        local distance = math.sqrt(square.vx ^ 2 + square.vy ^ 2)
        square.x = square.x + square.vx * square.s / distance * dt
        square.y = square.y + square.vy * square.s / distance * dt
        square.t = square.t + dt
        if square.t > 1 then
            square.a = false
        end
    end
    function square:draw()
        love.graphics.rectangle("fill", square.x, square.y, 5, 5)
    end
    return square
end

return Square