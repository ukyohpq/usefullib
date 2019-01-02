local super = Notifier
---@class Mediator:Notifier
Mediator = class("puremvc.patterns.mediator", super)

local NAME = "Mediator"

function Mediator:ctor(mediatorName, viewComponent)
    super.ctor(self)
	if mediatorName ~= nil then
		self.mediatorName = mediatorName
	else
		self.mediatorName = NAME
	end
	self.viewComponent = viewComponent
end

function Mediator:getMediatorName()
	return self.mediatorName
end

function Mediator:setViewComponent(viewComponent)
	self.viewComponent = viewComponent
end

function Mediator:getViewComponent()
	return self.viewComponent
end

function Mediator:listNotificationInterests()
	return {}
end

function Mediator:handleNotification(notification)
	
end

function Mediator:onRegister()
	
end

function Mediator:onRemove()
	
end

return Mediator