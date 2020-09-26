-- Projectile

local Projectile = {}
local projmap = {}
projmap[1] = {ptype="circle",r=3,s=600}
projmap[2] = {ptype="triangle",r=3,s=200}
function Projectile:get(world, conf)
    local newconf = projmap[conf['id']] or projmap[1]
    newconf.o = "proj"
    for k, v in pairs(newconf) do
        conf[k] = v
    end
    local object = {}
    if conf.ptype == "triangle" then
        object = Triangle:new(world, conf)
    else
        object = Circle:new(world, conf)
    end
    function object:update(dt)
        object.x = object.body:getX()
        object.y = object.body:getY()
        object.t = object.t - dt
    end
    return object
end

return Projectile