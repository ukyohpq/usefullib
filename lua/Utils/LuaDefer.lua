---
--- Created by hepengqi.
--- email:ukyohqp@qq.com
--- DateTime: 2019-03-14 10:49
--- 实现类似golang的defer的功能
---

local deferMap = {}
---defer
---@param fun fun(...)end
function defer(fun)
    local infoFunc = debug.getinfo(2).func
    local deferList = deferMap[infoFunc]
    if deferList == nil then
        deferList = {}
        deferMap[infoFunc] = deferList
    end
    table.insert(deferList, 1, fun)
    local hook = function()
        local hookInfoFunc = debug.getinfo(2).func
        if hookInfoFunc == infoFunc then
            for _, func in ipairs(deferList) do
                func()
            end
            deferMap[infoFunc] = {}
            debug.sethook()
        end
    end
    debug.sethook(hook, "r")
end
