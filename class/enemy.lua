-- Enemy

local Enemy = {}

function Enemy:new(world, config)
    local enemy = config
    enemy.a = true
    enemy.t = 0
    enemy.s = enemy.s or 600
    function enemy:update(dt)
        local distance = math.sqrt(enemy.vx ^ 2 + enemy.vy ^ 2)
        enemy.x = enemy.x + enemy.vx * enemy.s / distance * dt
        enemy.y = enemy.y + enemy.vy * enemy.s / distance * dt
        enemy.t = enemy.t + dt
        if enemy.t > 1 then
            enemy.a = false
        end
    end
    function enemy:draw()
        love.graphics.rectangle("fill", enemy.x, enemy.y, 5, 5)
    end
    return enemy
end

return Enemy