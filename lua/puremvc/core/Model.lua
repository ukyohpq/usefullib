local super = Singleton
---@class Model:Singleton
---@field proxyMap table<string, Proxy>
Model = class("puremvc.core.Model",  super)

function Model:initializeModel()
    
end

function Model:ctor()
	super.ctor(self)
	self.proxyMap = {}
	self:initializeModel(self)
end

---registerProxy
---@param proxy Proxy
function Model:registerProxy(proxy)
	self.proxyMap[proxy:getProxyName()] = proxy
	proxy:onRegister()
end

---retrieveProxy
---@param proxyName string
function Model:retrieveProxy(proxyName)
	return self.proxyMap[proxyName]
end

---hasProxy
---@param proxyName string
function Model:hasProxy(proxyName)
	return self.proxyMap[proxyName] ~= nil
end

---removeProxy
---@param proxyName string
function Model:removeProxy(proxyName)
	local proxy = self.proxyMap[proxyName]
	if proxy ~= nil then
	   self.proxyMap[proxyName] = nil
	   proxy:onRemove()
	end
	return proxy
end

return Model