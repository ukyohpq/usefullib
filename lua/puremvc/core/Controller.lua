local Controller = class("puremvc.core.Controller")
local private = {}
local instance
local SINGLETON_MSG = "Controller Singleton already constructed!"

local function initializeController(self)
    self[private]._view = require("puremvc.core.View").getInstance()
end

---------------------------
--@param
--@return
function Controller:ctor()
	if instance ~= nil then error(SINGLETON_MSG) end
	instance = self
	self[private] = {
	   _commandMap = {},
	   _view = nil
	}
	
	initializeController(self)
end


function Controller.getInstance()
    instance = instance or Controller.new()
    return instance
end


---------------------------
--@param
--@return
function Controller:executeCommand(note)
	local commandClassRef = self[private]._commandMap[note:getName()]
	if commandClassRef == nil then return end
    local commandInstace = commandClassRef.new()
    commandInstace:execute(note)
end


---------------------------
--@param
--@return
function Controller:registerCommand(notificationName, commandClassRef)
	if self[private]._commandMap[notificationName] == nil then
	   self[private]._view:registerObserver(notificationName, require("puremvc.patterns.observer.Observer").new(self.executeCommand, self))
	end
	self[private]._commandMap[notificationName] = commandClassRef
end


---------------------------
--@param
--@return
function Controller:hasCommand(notificationName)
	return self[private]._commandMap[notificationName] ~= nil
end


---------------------------
--@param
--@return
function Controller:removeCommand(notificationName)
	if self:hasCommand(notificationName) then
	   self[private]._view:removeObserver(notificationName, self)
	   self[private]._commandMap[notificationName] = nil
	end
end

return Controller