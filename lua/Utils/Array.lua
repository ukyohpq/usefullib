---
--- Created by ukyohpq.
--- DateTime: 17/11/24 10:53
---

---@class Array
---@field len number
local Array = class("Array")
local arrLenMap = {}
setmetatable(arrLenMap, {__mode = "k"})
---increaseLen
---@param self Array
local function increaseLen(self)
    arrLenMap[self] = arrLenMap[self] + 1
end

---reduceLen
---@param self Array
local function reduceLen(self)
    arrLenMap[self] = arrLenMap[self] - 1
end

function Array:ctor(...)
    local len = 0
    for i, v in ipairs({...}) do
        self[i] = v
        len = len + 1
    end
    arrLenMap[self] = len
end

function Array:getLength()
    return arrLenMap[self]
end

---push
---@param element table
---@return number
function Array:push(element)
    return self:addElementAt(element)
end

function Array:pop()
    if arrLenMap[self] == 0 then
        return
    end
    local ele = table.remove(self)
    reduceLen(self)
    return ele
end

function Array:addElementAt(element, index)
    table.insert(self, element, index)
    increaseLen(self)
    return self:getLength()
end

function Array:indexOf(element)
    for i, v in ipairs(self) do
        if element == v then
            return i
        end
    end
    return -1
end

function Array:removeElementAt(index)
    if index < 1 then
        return nil
    end
    table.remove(self, index)
    return self[index]
end

function Array:removeElement(element)
    local index = self:indexOf(element)
    if index == -1 then
        return
    end
    return self:removeElementAt(index)
end
return Array