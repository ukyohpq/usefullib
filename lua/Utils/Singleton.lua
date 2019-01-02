require("class")
---@class Singleton
Singleton = class("Singleton")

---@type Singleton[]
local instanceMap = {}
function Singleton:ctor()
    if instanceMap[self] then
        error(string.format("Singleton [ %s ] us already constructed!", self.__cname))
    end
end

function Singleton:getInstance()
    local instance = instanceMap[self]
    if instance == nil then
        instance = self.new()
        instanceMap[self] = instance
    end
    return instance
end

return Singleton