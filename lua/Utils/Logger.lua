---
--- Created by hepengqi.
--- DateTime: 2017/11/16 23:53
---

local function WriteF(fmt, ...)
    local p = {...}
    --默认第一个为nil的参数到最后一个参数之间的参数数量不会超过10个
    local length = #p + 10
    for i = 1, length do
        local v = p[i]
        if v == nil then
            p[i] = "nil"
        elseif type(v) ~= "number" then
            p[i] = tostring(v)
        end
        p[i] = tostring(v)
    end
    return string.format(fmt, unpack(p))
end

function logDebug(fmtString,...)
    Debugger.Log("{0} \n {1}", "[ " .. WriteF(fmtString, ...) .. " ]", debug.traceback())
end

function logWarning(fmtString, ...)
    Debugger.LogWarning("{0} \n {1}", "[ <color=#FFFF00>" .. WriteF(fmtString, ...) .. " </color>]", debug.traceback())
end

function logError(fmtString, ...)
    local stack = "[ " .. debug.traceback() .. " ]"
    Debugger.LogError("{0} \n {1}", "[ <color=#FF0000>" .. WriteF(fmtString, ...) .. " </color>]", debug.traceback())
end