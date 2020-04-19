-- Char

local Char = {}

function Char:new(name)
    local char = {}
    char.name = name
    char.str = 0
    char.dex = 0
    char.int = 0
    char.skills = {}
    char.equips = {}
    char.items = {}
    return char
end

return Char
