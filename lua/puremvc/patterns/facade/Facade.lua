require("Utils.Singleton")
require("puremvc.core.Model")
require("puremvc.core.Controller")
require("puremvc.core.View")
require("puremvc.patterns.observer.Notification")

local super = Singleton
---@class Facade:Singleton
---@field private model Model
---@field private controller Controller
---@field private view View
Facade = class("src.puremvc.patterns.facade.Facade", super)


function Facade:initializeModel()
    if self.model == nil then
        self.model = Model:getInstance()
    end
end

function Facade:initializeController()
    if self.controller == nil then
        self.controller = Controller:getInstance()
    end
end

function Facade:initializeView()
    if self.view == nil then
        self.view = View:getInstance()
    end
end

function Facade:initializeFacade()
    self:initializeModel()
    self:initializeController()
    self:initializeView()
end

function Facade:ctor()
    super.ctor(self)
	self:initializeFacade()
end

function Facade:registerCommand(notificationName, commandClassRef)
    self.controller:registerCommand(notificationName, commandClassRef)
end

function Facade:removeCommand(notificationName)
    self.controller:removeCommand(notificationName)
end

function Facade:hasCommand(notificationName)
	return self.controller:hasCommand(notificationName)
end

function Facade:registerProxy(proxy)
	self.model:registerProxy(proxy)
end

function Facade:retrieveProxy(proxyName)
	return self.model:retrieveProxy(proxyName)
end

function Facade:removeProxy(proxyName)
    local proxy
    if self.model ~= nil then
        proxy = self.model:removeProxy(proxyName)
    end
    return proxy
end

function Facade:hasProxy(proxyName)
	return self.model:hasProxy(proxyName)
end

function Facade:registerMediator(mediator)
	if self.view ~= nil then
	   self.view:registerMediator(mediator)
	end
end

function Facade:retrieveMediator(mediatorName)
	return self.view:retrieveMediator(mediatorName)
end


function Facade:removeMediator(mediatorName)
    local mediator
    if self.view ~= nil then 
        mediator = self.view:removeMediator(mediatorName)
    end
    return mediator
end

function Facade:hasMediator(mediatorName)
	return self.view:hasMediator(mediatorName)
end

function Facade:sendNotification(notificationName, body, type)
    self:notifyObservers(Notification.new(notificationName, body, type))
end

function Facade:notifyObservers(notification)
	if self.view ~= nil then
	   self.view:notifyObservers(notification)
	end
end

---@return Facade
function Facade:getInstance()
    return super.getInstance(self)
end

return Facade