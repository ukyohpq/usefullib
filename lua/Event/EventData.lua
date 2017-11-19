---
--- Created by Administrator.
--- DateTime: 2017/11/19 19:25
---

---@class Event.EventData
---@field eventTarget table
---@field data table
local EventData = class("Event.EventData")

function EventData:ctor(eventTarget, data)
    self.eventTarget = eventTarget
    self.data = data
end

function EventData:getTarget()
    return self.eventTarget
end

function EventData:getData()
    return self.data
end

return EventData