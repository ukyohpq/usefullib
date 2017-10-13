local Observer = class("puremvc.patterns.observer.Observer")

local private = {}


---------------------------
--@param
--@return
function Observer:ctor(notifyMethod, notifyContext)
	self[private] = {
	   _notify = nil,
	   _context = nil
	}
	
	self:setNotifyMethod(notifyMethod)
	self:setNotifyContext(notifyContext)
end



---------------------------
--@param
--@return
function Observer:setNotifyMethod(notifyMethod)
	self[private]._notify = notifyMethod
end


---------------------------
--@param
--@return
function Observer:setNotifyContext(notifyContext)
	self[private]._context = notifyContext
end


---------------------------
--@param
--@return
function Observer:getNotifyMethod()
	return self[private]._notify
end


---------------------------
--@param
--@return
function Observer:getNotifyContext()
	return self[private]._context
end


---------------------------
--@param
--@return
function Observer:notifyObserver(notification)
	self:getNotifyMethod()(self:getNotifyContext(), notification)
end


---------------------------
--@param
--@return
function Observer:compareNotifyContext(object)
	return object == self[private]._context
end

return Observer