-- Config

local Config = {}

function Config:newObj(config)
    local config = config
    config.a = config.a or true -- alive
    config.x = config.x or 0 -- position x
    config.y = config.y or 0 -- position y
    config.t = config.t or 1 -- life time
    config.s = config.s or 1000 -- speed
    config.r = config.r or 1 -- radius
    config.m = config.m or 1 -- mass
    config.hp = config.hp or 1 -- health point
    config.maxhp = config.hp or 1 -- max health point
    -- projectile or obstacle or player or enemy
    config.o = config.o or "proj" -- object type
    config.bodytype = "dynamic"
    return config
end

return Config