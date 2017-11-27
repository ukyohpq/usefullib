---
--- Created by Administrator.
--- DateTime: 2017/11/16 23:53
---
local print = _G.print
local function getStack()
    return string.gsub(debug.traceback(), "(stack traceback:).+(in function 'logErr'\n)", "")
end

local function getTrackString(...)
    local s = ""
    for _, v in ipairs({...}) do
        s = s .. tostring(v) .. " "
    end
    s = s .. "\n"
    local stack = string.gsub(debug.traceback(), "(stack traceback:).+(in function 'logErr'\n)", "")
    s = s .. stack
    return s
end

function logErr(...)
    local s = getTrackString(...)
    print(s)
end