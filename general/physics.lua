local Physics = {}

Physics.world = love.physics.newWorld(0, 0, true)

function Physics:load()
    Physics.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end
function Physics:update(dt)
    Physics.world:update(dt)
end

function beginContact(a, b, coll)
    x, y = coll:getNormal()
    local aobj = a:getBody():getUserData()
    local bobj = b:getBody():getUserData()
    if aobj.o == "proj" or bobj.o == "proj" then
        aobj.hp = aobj.hp - 1
        bobj.hp = bobj.hp - 1
    end
    if aobj.o == "port" and bobj.o == "play" then
        Restart = true
    elseif bobj.o == "port" and aobj.o == "play" then
        Restart = true
    end
end

function endContact(a, b, coll)
end
function preSolve(a, b, coll)
end
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end

return Physics