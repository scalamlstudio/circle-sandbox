-- Player

local Player = {}

function Player:new(name)
    local player = {}
    
    local key1 = tostring(love.math.random(1000000, 9999999))
    local key2 = tostring(love.math.random(1000000, 9999999))
    local key3 = tostring(love.math.random(1000000, 9999999))
    player.id = key1 + key2 + key3
    player.name = name
    player.chars = {}
    player.stash = {}

    function player:addChar(char)
        player.chars[#player.chars + 1] = char
    end

    return player
end

return Player
