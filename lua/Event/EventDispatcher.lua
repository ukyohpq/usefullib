---
--- Created by Administrator.
--- DateTime: 2017/11/19 19:09
---

local EventPriorityMap = require("Event.EventPriorityMap")

---@class Event.EventDispatcher
---@field eventTarget Event.EventDispatcher
---@field handlerDic table<string, Event.EventPriorityMap> @dic1--key:eventName, value:dic2;dic2--key:priority, value:handlerList 强引用表
---@field priorities number[]
local EventDispatcher = class("Event.EventDispatcher")

function EventDispatcher:ctor(eventTarget)
    self.eventTarget = eventTarget or self
    self.handlerDic = {}
    local weekHandlerList = {}
    local mt = {__mode = "kv"}
    setmetatable(weekHandlerList, mt)
    self.weekHandlerList = weekHandlerList
end

---dispatchEvent
---@param eventName string
---@param data table
function EventDispatcher:dispatchEvent(eventName, data)
    local eventDic = self.handlerDic[eventName]
    if eventDic == nil then return end
    eventDic:triggerEvent(eventName, data, self.eventTarget)
    if eventDic:hasEventHandler() == false then
        self.handlerDic[eventName] = nil
    end
end

---addEventListener
---@param eventName string
---@param handler fun(self:table, eventData:Event.EventData):void
---@param handlerCaller table
---@param priority number
---@param useWeekReference boolean
function EventDispatcher:addEventListener(eventName, handler, handlerCaller, priority, useWeekReference)
    if eventName == nil then return end
    if handler == nil then return end
    priority = priority or 0

    local dic = self.handlerDic
    local eventMap = dic[eventName]
    if eventMap == nil then
        eventMap = EventPriorityMap.new()
        dic[eventName] = eventMap
    end

    eventMap:addEventHandler(handler, handlerCaller, priority, useWeekReference)
end

---removeEventListener
---@param eventName string
---@param handler fun(self:table, eventData:Event.EventData):void
---@param handlerCaller table
---@param priority number
---@param useWeekReference boolean
function EventDispatcher:removeEventListener(eventName, handler, handlerCaller, priority, useWeekReference)
    if eventName == nil then return end
    priority = priority or 0
    local list = self.handlerDic
    local eventList = list[eventName]
    if eventList == nil then return end
    eventList:removeEventHandler(handler, handlerCaller, priority, useWeekReference)
    if eventList:hasEventHandler() == false then
        list[eventName] = nil
    end
end

--function EventDispatcher:hasEventListener(eventName)
--
--end

return EventDispatcher