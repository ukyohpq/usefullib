local Proxy = class("puremvc.patterns.proxy", require("puremvc.patterns.observer.Notifier"))
local private = {}
local super = Proxy.super
Proxy.NAME = "Proxy"

---------------------------
--@param
--@return
function Proxy:ctor(proxyName, data)
    super.ctor(self)
	self[private] = {
	   _proxyName = nil,
	   _data = nil
	}
	
	if proxyName == nil then
	   self[private]._proxyName = NAME
	else
       self[private]._proxyName = proxyName
	end
	
	if data ~= nil then
	   self:setData(data)
	end
end


---------------------------
--@param
--@return
function Proxy:setData(data)
	self[private]._data = data
end


---------------------------
--@param
--@return
function Proxy:getProxyName()
	return self[private]._proxyName
end


---------------------------
--@param
--@return
function Proxy:getData()
	return self[private]._data
end


---------------------------
--@param
--@return
function Proxy:onRegister()
	
end


---------------------------
--@param
--@return
function Proxy:onRemove()
	
end

return Proxy