---
--- Created by Administrator.
--- DateTime: 2017/11/20 0:13
---
local EventHandler = require("Event.EventHandler")
local EventData = require("Event.EventData")

---@class Event.EventPriorityMap
---@field priorities number[]
---@field map table<number, Event.EventHandler[]>
local EventPriorityMap = class("Event.EventPriorityMap")

function EventPriorityMap:ctor()
    self.priorities = {}
    self.map = {}
end

---addEventHandler
---@param handler fun(self:table, eventData:Event.EventData):void
---@param handlerCaller table
---@param priority number
---@param useWeekReference boolean
function EventPriorityMap:addEventHandler(handler, handlerCaller, priority, useWeekReference)
    local priorityList = self.map[priority]
    if priorityList == nil then
        self:addPriority(priority)
        priorityList = {}
        self.map[priority] = priorityList
    end

    for _, handler in ipairs(priorityList) do
        if handler:equal(handlerCaller, handler, useWeekReference) then
            return
        end
    end
    table.insert(priorityList, EventHandler.new(handlerCaller, handler, useWeekReference))
end

---removeEventHandler
---@param handler fun(self:table, eventData:Event.EventData):void
---@param handlerCaller table
---@param priority number
---@param useWeekReference boolean
function EventPriorityMap:removeEventHandler(handler, handlerCaller, priority, useWeekReference)
    local priorityList = self.map[priority]
    if priorityList == nil then return end
    for i = #priorityList, 1, -1 do
        if priorityList[i]:equal(handlerCaller, handler, useWeekReference) then
            table.remove(priorityList, i)
            if #priorityList == 0 then
                self.map[priority] = nil
                self:removePriority(priority)
            end
        end
    end
end

function EventPriorityMap:hasEventHandler()
    return #self.priorities > 0
end

---dispatchEvent
---@param eventName string
---@param data table
---@param eventTarget table
function EventPriorityMap:triggerEvent(eventName, data, eventTarget)
    for _, priority in ipairs(self.priorities) do
        local priorityList = self.map[priority]
        if priorityList ~= nil then
            for _, callbackHandler in ipairs(priorityList) do
                local ret = callbackHandler:call(EventData.new(eventTarget, data))
                if ret == false then
                    self:removeEventHandler(nil, callbackHandler.caller, priority, callbackHandler.useWeekReference)
                end
                return ret
            end
        end
    end
end

function EventPriorityMap:addPriority(priority)
    if #self.priorities == 0 then
        table.insert(self.priorities, priority)
        return
    else
        for i, p in ipairs(self.priorities) do
            if priority == p then
                return
            elseif priority > p then
                table.insert(self.priorities, i, priority)
                return
            end
        end
    end
    table.insert(self.priorities, priority)
end

function EventPriorityMap:removePriority(priority)
    for i = #self.priorities, 1, -1 do
        if self.priorities[i] == priority then
            table.remove(self.priorities, i)
            return
        end
    end
end

return EventPriorityMap