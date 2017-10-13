local View = class("puremvc.core.View")
local private = {}
local instance
local SINGLETON_MSG = "View Singleton already constructed!"

local function initializeView(self)
    
end
---------------------------
--@param
--@return
function View:ctor()
	if instance ~= nil then
	   error(SINGLETON_MSG)
	end
	instance = self
	self[private] = {
	   _mediatorMap = {},
	   _observerMap = {}
	}
	initializeView(self)
end


---------------------------
--@param
--@return
function View.getInstance()
	instance = instance or View.new()
	return instance
end

function View:registerObserver(notificationName, observer)
    local observers = self[private]._observerMap[notificationName]
    if observers ~= nil then
        observers[#observers] = observer
    else
        self[private]._observerMap[notificationName] = {observer}
    end
end


---------------------------
--@param
--@return
function View:notifyObservers(notification)
	if self[private]._observerMap[notification:getName()] ~= nil then
	   local observers_ref = self[private]._observerMap[notification:getName()]
	   --把observers从原始数组拷贝到工作数组中
	   --如果不这么做的话，原始数组可能在消息循环进行时发生改变
	   local observers = {}
	   local observer
	   for i=1, #observers_ref do
	       observer = observers_ref[i]
	       observers[i] = observer
	   end
	   
	   for i=1, #observers do
	       observer = observers[i]
	       observer:notifyObserver(notification)	   	
	   end
	end
end


---------------------------
--@param
--@return
function View:removeObserver(notificationName, notifyContext)
	local observers = self[private]._observerMap[notificationName]
	for i=1, #observers do
		if observers[i]:compareNotifyContext(notifyContext) then
		  table.remove(observers,i)
		  break
		end
	end
	
	if #observers == 0 then
	   self[private]._observerMap[notificationName] = nil 
	end
end


---------------------------
--@param
--@return
function View:registerMediator(mediator)
    if self[private]._mediatorMap[mediator:getMediatorName()] ~= nil then return end
    self[private]._mediatorMap[mediator:getMediatorName()] = mediator
    local interests = mediator:listNotificationInterests()
    if #interests > 0 then
       local observer = require("puremvc.patterns.observer.Observer").new(mediator.handleNotification, mediator)
       for i=1, #interests do
       	self:registerObserver(interests[i], observer)
       end
    end
    mediator:onRegister()
end


---------------------------
--@param
--@return
function View:retireveMediator(mediatorName)
	return self[private]._mediatorMap[mediatorName]
end

---------------------------
--@param
--@return
function View:removeMediator(mediatorName)
	local mediator = self[private]._mediatorMap[mediatorName]
	if mediator ~= nil then
	   local interests = mediator:listNotificationInterests()
	   for i=1, #interests do
	   	self:removeObserver(interests[i], mediator)
	   	self[private]._mediatorMap[mediatorName] = nil
	   end
	   mediator:onRemove()
	end
	return mediator
end


---------------------------
--@param
--@return
function View:hasMediator(mediatorName)
	return self[private]._mediatorMap[mediatorName] ~= nil
end

return View