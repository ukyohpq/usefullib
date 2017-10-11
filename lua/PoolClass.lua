require "System.class"

---
-- 1.删除field的release方法，之前是用一个匿名tabel作为key，给每个ins在创建时添加上一个field，
-- 指向一个local方法，现在直接调用这个local方法，把ins作为参数传入
-- 2.删除了对于ins自定义release字段的type的检测，如果不是function，调用会报错
--

local poolMap = {}
---
-- 删除instance上所有自身创建的字段
--
local function release(ins)
    for key, value in pairs(ins) do
        ins[key] = nil
    end
end

local function put(ins)
    if ins.release ~= nil then
        ins:release()
    end
    release(ins)
    local pool = poolMap[ins.class]
    table.insert(pool,ins)
end

---
-- 判断一个instance是否是指定类型，或者其子类
--
local function is(ins, cls)
    local function f(c)
        if c == cls then
            return true
        else
            if c.super ~= nil then
                return f(c.super)
            else
                return false
            end
        end
    end
    return f(ins.class)
end

function poolClass(className, super)
    --调用原来的class方法生产一个"class"
    local cls = class(className, super)
    --	为这个"class"附着对象池相关的方法
    --  为cls创建class字段，这样在release instance的时候，就不需要对关键字"class"进行特殊处理
    cls.class = cls
    --	为class添加Put方法，用于放入该class对应的对象池
    cls.put = put
    --	为class添加Is方法，判断instance是否是指定class的类型或者子类
    cls.is = is
    --	为class构造对象池
    local pool = {}
    poolMap[cls] = pool
    --  重新定义new方法
    local oldNew = cls.new
    cls.new = function(...)
        local numIns = #pool
        local ins
        if numIns == 0 then
            ins = oldNew(...)
            ins.class = nil
        else
            ins = pool[numIns]
            table.remove(pool, numIns)
            ins:ctor(...)
        end
        return ins
    end
    return cls
end

---
-- 清除指定类型的对象池
--
function clearPool(cls)
    local pool = poolMap[cls]
    for i = #pool, 1, -1 do
        table.remove(pool, i)
    end
end

---
-- 清除所有对象池
--
function clearPools()
    for _, pool in pairs(poolMap) do
        for i = #pool, 1, -1 do
            table.remove(pool, i)
        end
    end
end
