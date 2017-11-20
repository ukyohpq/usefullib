---
--- Created by ukyohpq.
--- DateTime: 17/11/20 18:20
---

function table.removeElement(tb, ele)
    for i = #tb, 1, -1 do
        if tb[i] == ele then
            table.remove(tb, i)
            return
        end
    end
end