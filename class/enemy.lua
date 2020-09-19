-- Enemy

local Enemy = {}
local enemymap = {}
enemymap[1] = {o="enem",s=100,r=8,hp=10,t=1.427e8}
enemymap[2] = {o="enem",s=100,r=12,etype="range",hp=20,t=1.427e8}
function Enemy:get(world, conf)
    local newconf = enemymap[conf['id']] or enemymap[1]
    for k, v in pairs(newconf) do
        conf[k] = v
    end
    local obj = Triangle:new(world, conf)
    return obj
end

return Enemy