---
--- Created by ukyohpq.
--- DateTime: 17/11/21 14:28
---

---@class History.HistoryRecorder
---@field recordList table[]
---@field iterate number
---@field maxLen number
local HistoryRecorder = class("History.HistoryRecorder")

function HistoryRecorder:ctor()
    self:reset()
end

function HistoryRecorder:createRecord(record)
    self.iterate = self.iterate + 1
    self.maxLen = self.iterate
    self.recordList[self.maxLen] = record
end

function HistoryRecorder:undo()
    if self.iterate > 0 then
        self.iterate = self.iterate - 1
    end
end

function HistoryRecorder:redo()
    if self.iterate < self.maxLen then
        self.iterate = self.iterate + 1
    end
end

function HistoryRecorder:getRecord()
    return self.recordList[self.iterate]
end

function HistoryRecorder:reset()
    self.iterate = 0
    self.maxLen = 0
    self.recordList = {}
end

function HistoryRecorder:hasRecord()
    return self.iterate > 0
end
return HistoryRecorder