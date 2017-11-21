---
--- Created by ukyohpq.
--- DateTime: 17/11/21 16:27
---
require("class")
local HistoryRecorder = require("History.HistoryRecorder")

local function testCreateRecord()
    local ret = false
    local testFun = function()
        local recorder= HistoryRecorder.new()
        recorder:createRecord(1)
        if recorder:getRecord() ~= 1 then
            ret = false
            return
        end
        recorder:createRecord(2)
        ret = recorder:getRecord() == 2
    end
    testFun()
    if ret then
        print("testCreateRecord success")
    else
        print("testCreateRecord failed")
    end
end

local function testUndo()
    local ret = false
    local testFun = function()
        local recorder= HistoryRecorder.new()
        recorder:createRecord(1)
        recorder:undo()
        if recorder:getRecord() ~= nil then
            ret = false
        end
        recorder:createRecord(2)
        recorder:createRecord(3)
        recorder:undo()
        ret = recorder:getRecord() == 2
    end
    testFun()
    if ret then
        print("testUndo success")
    else
        print("testUndo failed")
    end
end

local function testRedo()
    local ret = false
    local testFun = function()
        local recorder= HistoryRecorder.new()
        recorder:createRecord(1)
        recorder:createRecord(2)
        recorder:createRecord(3)
        recorder:undo()
        recorder:undo()
        recorder:redo()
        ret = recorder:getRecord() == 2
    end
    testFun()
    if ret then
        print("testRedo success")
    else
        print("testRedo failed")
    end
end

testCreateRecord()
testUndo()
testRedo()