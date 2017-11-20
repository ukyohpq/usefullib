---
--- Created by ukyohpq.
--- DateTime: 17/11/20 15:59
---
package.path = package.path .. ";../?.lua"
require("class")
local EventDispatcher= require("Event.EventDispatcher")


local function withOutCallerTest()
    local ret = false
    local testFun = function()
        local dispatcher = EventDispatcher.new()
        local func = function(self, eventData)
            ret = eventData:getData() == 10 and eventData:getTarget() == dispatcher
        end
        dispatcher:addEventListener("evt", func, nil, 0, false)
        dispatcher:dispatchEvent("evt", 10)
    end
    testFun()
    if ret then
        print("withOutCallerTest success")
    else
        print("withOutCallerTest failed")
    end
end

local function withCallerTest()
    local ret = false
    local testFun = function()
        local dispatcher = EventDispatcher.new()
        local b = {}
        b.func = function(self, eventData)
            ret = eventData:getData() == 10 and eventData:getTarget() == dispatcher and self == b
        end
        dispatcher:addEventListener("evt", b.func, b, 0, false)
        dispatcher:dispatchEvent("evt", 10)
    end
    testFun()
    if ret then
        print("withCallerTest success")
    else
        print("withCallerTest failed")
    end
end

local function weekReferenceTest()
    local ret = true
    local testFun = function()
        local dispatcher = EventDispatcher.new()
        local b = {}
        b.func = function(self, eventData)
            ret = false
        end
        dispatcher:addEventListener("evt", b.func, b, 0, true)
        b.func = nil
        collectgarbage()
        dispatcher:dispatchEvent("evt", 10)
        if dispatcher.handlerDic["evt"] ~= nil then
            ret = false
        end
    end
    testFun()
    if ret then
        print("weekReferenceTest success")
    else
        print("weekReferenceTest failed")
    end
end

local function priorityTest()
    local rets = {}
    local testFun = function()
        local dispatcher = EventDispatcher.new()
        local b = {}
        b.func1 = function(self, eventData)
            table.insert(rets, 1)
        end
        b.func2 = function(self, eventData)
            table.insert(rets, 2)
        end

        dispatcher:addEventListener("evt", b.func1, b, 0, false)
        dispatcher:addEventListener("evt", b.func2, b, 10, false)
        dispatcher:dispatchEvent("evt", 10)
    end
    testFun()
    if rets[1] == 2 and rets[2] == 1 then
        print("priorityTest success")
    else
        print("priorityTest failed")
    end
end

local function removeTest()
    local ret = true
    local testFun = function()
        local dispatcher = EventDispatcher.new()
        local b = {}
        b.func = function(self, eventData)
            ret = false
        end
        dispatcher:addEventListener("evt", b.func, b, 0, false)
        dispatcher:removeEventListener("evt", b.func, b, 0, false)
        dispatcher:dispatchEvent("evt", 10)
    end
    testFun()
    if ret then
        print("removeTest success")
    else
        print("removeTest failed")
    end
end


withOutCallerTest()
withCallerTest()
weekReferenceTest()
priorityTest()
removeTest()