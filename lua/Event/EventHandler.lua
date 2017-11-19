---
--- Created by Administrator.
--- DateTime: 2017/11/19 19:24
---

---@class Event.EventHandler
---@field caller table
---@field callbackDic table<fun(self:table, eventData:Event.EventData):void, number>
---@field useWeekReference boolean
local EventHandler = class("Event.EventHandler")

---ctor
---@param caller table @回调函数的self
---@param callback fun(self:table, eventData:Event.EventData):void @回调函数的map，其key即为回调函数
---@param useWeekReference boolean @是否弱引用
function EventHandler:ctor(caller, callback, useWeekReference)
    self.caller = caller
    self.callbackDic = {}
    self.useWeekReference = useWeekReference
    if useWeekReference then
        local mt = {__mode = "k"}
        setmetatable(self.callbackDic, mt)
    end
    if callback == nil then
        error("callback must not be nil")
    end
    self.callbackDic[callback] = 1
end

---回调。如果正确调用，则返回true；如果callback已经被gc(弱引用)，则返回false
---@param eventData Event.EventData
---@return boolean @如果正确调用，则返回true；如果callback已经被gc(弱引用)，则返回false
function EventHandler:call(eventData)
    for callback, _ in pairs(self.callbackDic) do
        callback(self.caller, eventData)
        return true
    end
    return false
end


---equal
---@param caller table
---@param callback fun(self:table, eventData:Event.EventData):void
---@param useWeekReference boolean
function EventHandler:equal(caller, callback, useWeekReference)
    if self.caller ~= caller then return false end
    if self.useWeekReference ~= useWeekReference then return false end
    local hasCallback = false
    for selfCallback, _ in pairs(self.callbackDic) do
        hasCallback = true
        return selfCallback == callback
    end
    return true
end

return EventHandler