-- Obstacle

local Obstacle = {}
local obstaclemap = {}
obstaclemap[1] = {o="obst",r=400, hp=1.427e8, t=1.427e8}
obstaclemap[2] = {o="obst",r=200, hp=10, t=1.427e8}
function Obstacle:get(world, conf)
    local newconf = obstaclemap[conf['id']] or obstaclemap[1]
    for k, v in pairs(newconf) do
        conf[k] = v
    end
    local obj = Square:new(world, conf)
    return obj
end

return Obstacle