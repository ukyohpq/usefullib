local Notifier = class("puremvc.patterns.observer.Notifier")

local private = {}


---------------------------
--@param
--@return
function Notifier:ctor()
	self[private] = {
	   _facade = require("puremvc.patterns.facade.Facade").getInstance()
	}
end


---------------------------
--@param
--@return
function Notifier:sendNotification(notificationName, body, type)
	self[private]._facade:sendNotification(notificationName, body, type)
end

return Notifier