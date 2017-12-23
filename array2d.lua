local Object = require "class/classic"
local Array2d = Object:extend()

function Array2d:new()
    self.items = {}
end

function Array2d:set(x, y, value)
    if self.items[x] == nil then
        self.items[x] = {}
    end
    self.items[x][y] = value
end

function Array2d:get(x, y)
    if self.items[x] ~= nil then
        return self.items[x][y]
    end
end

function Array2d:clear()
    self.items = {}
end

function Array2d:iter()
    local iterationTable = {}
    for x, row in pairs(self.items) do
        for y, value in pairs(row) do
            table.insert(iterationTable, {x = x, y = y, value = value})
        end
    end
    local length = #iterationTable
    local counter = 1
    return function()
        if counter <= length then
            local item = iterationTable[counter]
            counter = counter + 1
            return item.x, item.y, item.value
        end
    end
end

function Array2d:iterRows()
    return pairs(self.items)
end

return Array2d
