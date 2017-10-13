local SimpleCommand = class("puremvc.patterns.command.SimpleCommand",require("puremvc.patterns.observer.Notifier"))
local super = SimpleCommand.super
---------------------------
--@param
--@return
function SimpleCommand:ctor()
    super.ctor(self)
end
---------------------------
--@param
--@return
function SimpleCommand:execute(notification)
	
end
return SimpleCommand