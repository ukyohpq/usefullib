local Mediator = class("puremvc.patterns.mediator", require("puremvc.patterns.observer.Notifier"))
local private = {}
local super = Mediator.super
Mediator.NAME = "Mediator"

---------------------------
--@param
--@return
function Mediator:ctor(mediatorName, viewComponent)
    super.ctor(self)
	self[private] = {
	   _mediatorName = nil,
	   _viewComponent = viewComponent
	}
	
	if mediatorName ~= nil then
	   self[private]._mediatorName = mediatorName
	else
	   self[private]._mediatorName = NAME
	end
end


---------------------------
--@param
--@return
function Mediator:getMediatorName()
	return self[private]._mediatorName
end


---------------------------
--@param
--@return
function Mediator:setViewComponent(viewComponent)
	self[private]._viewComponent = viewComponent
end


---------------------------
--@param
--@return
function Mediator:getViewComponent()
	return self[private]._viewComponent
end


---------------------------
--@param
--@return
function Mediator:listNotificationInterests()
	return {}
end


---------------------------
--@param
--@return
function Mediator:handleNotification(notification)
	
end


---------------------------
--@param
--@return
function Mediator:onRegister()
	
end


---------------------------
--@param
--@return
function Mediator:onRemove()
	
end

return Mediator