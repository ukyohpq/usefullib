local Facade = class("src.puremvc.patterns.facade.Facade")
local private = {}

local SINGLETON_MSG = "Facade Singleton already constructed!"

local function initializeModel(self)
    if self[private]._model == nil then
        self[private]._model = require("puremvc.core.Model").getInstance()
    end
end

local function initializeController(self)
    if self[private]._controller == nil then
        self[private]._controller = require("puremvc.core.Controller").getInstance()
    end
end

local function initializeView(self)
    if self[private]._view == nil then
        self[private]._view = require("puremvc.core.View").getInstance()
    end
end

local function initializeFacade(self)
    initializeModel(self)
    initializeController(self)
    initializeView(self)
end

---------------------------
--@param
--@return
function Facade:ctor()
	self[private] = {}
	--这样写有问题，因为运算优先级的缘故，会从左至右，先not，于是得到一个false，再判断false是否等于nil，于是一定是false
	--所以要么写成if not (instance == nil) then， 要么写成if instance ~= nil then
--	if not instance == nil then
	if instance ~= nil then
        error(SINGLETON_MSG)
	end
	
	instance = self
	initializeFacade(self)
end

---
--static
--
function Facade.getInstance()
    instance = instance or Facade.new()
    return instance
end

function Facade:registerCommand(notificationName, commandClassRef)
    self[private]._controller:registerCommand(notificationName, commandClassRef)
end

function Facade:removeCommand(notificationName)
    self[private]._controller:removeCommand(notificationName)
end


---------------------------
--@param
--@return
function Facade:hasCommand(notificationName)
	return self[private]._controller:hasCommand(notificationName)
end


---------------------------
--@param
--@return
function Facade:registerProxy(proxy)
	self[private]._model:registerProxy(proxy)
end


---------------------------
--@param
--@return
function Facade:retrieveProxy(proxyName)
	return self[private]._model:retrieveProxy(proxyName)
end


---------------------------
--@param
--@return
function Facade:removeProxy(proxyName)
    local proxy
    if self[private]._model ~= nil then
        proxy = self[private]._model:removeProxy(proxyName)
    end
    return proxy
end


---------------------------
--@param
--@return
function Facade:hasProxy(proxyName)
	return self[private]._model:hasProxy(proxyName)
end


---------------------------
--@param
--@return
function Facade:registerMediator(mediator)
	if self[private]._view ~= nil then
	   self[private]._view:registerMediator(mediator)
	end
end


---------------------------
--@param
--@return
function Facade:retrieveMediator(mediatorName)
	return self[private]._view:retrieveMediator(mediatorName)
end


function Facade:removeMediator(mediatorName)
    local mediator
    if self[private]._view ~= nil then 
        mediator = self[private]._view:removeMediator(mediatorName)
    end
    return mediator
end


---------------------------
--@param
--@return
function Facade:hasMediator(mediatorName)
	return self[private]._view:hasMediator(mediatorName)
end


---------------------------
--@param
--@return
function Facade:sendNotification(notificationName, body, type)
    self:notifyObservers(require("puremvc.patterns.observer.Notification").new(notificationName, body, type))
end


---------------------------
--@param
--@return
function Facade:notifyObservers(notification)
	if self[private]._view ~= nil then
	   self[private]._view:notifyObservers(notification)
	end
end


return Facade