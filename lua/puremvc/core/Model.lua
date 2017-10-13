local Model = class("puremvc.core.Model")
local private = {}
local instance
local SINGLETON_MSG = "Model Singleton already constructed!"

local function initializeModel(self)
    
end
---------------------------
--@param
--@return
function Model:ctor()
	if instance ~= nil then
	   error(SINGLETON_MSG)
	end
	instance = self
	self[private] = {
	   _proxyMap = {}
	}
	
	initializeModel(self)
end


---------------------------
--@param
--@return
function Model.getInstance()
	instance = instance or Model.new()
	return instance
end


---------------------------
--@param
--@return
function Model:registerProxy(proxy)
	self[private]._proxyMap[proxy:getProxyName()] = proxy
	proxy:onRegister()
end


---------------------------
--@param
--@return
function Model:retrieveProxy(proxyName)
	return self[private]._proxyMap[proxyName]
end


---------------------------
--@param
--@return
function Model:hasProxy(proxyName)
	return self[private]._proxyMap[proxyName]
end


---------------------------
--@param
--@return
function Model:removeProxy(proxyname)
	local proxy = self[private]._proxyMap[proxyName]
	if proxy ~= nil then
	   self[private]._proxyMap[proxyName] = nil
	   proxy:onRemove()
	end
	return proxy
end
return Model