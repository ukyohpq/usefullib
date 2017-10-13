local MacroCommand = class("puremvc.patterns.command.MacroCommand", require("puremvc.patterns.observer.Notifier"))
local private = {}
local super = MacroCommand.super
local function initializeMacroCommand(self)
	
end
---------------------------
--@param
--@return
function MacroCommand:ctor()
    super.ctor(self)
	self[private] = {
	   _subCommands = {}
	}
    initializeMacroCommand(self)
end


---------------------------
--@param
--@return
function MacroCommand:addSubCommand(commandClassRef)
    local table = self[private]._subCommands
	table[#table + 1] = commandClassRef
end


---------------------------
--@param
--@return
function MacroCommand:execute(notification)
    local tb = self[private]._subCommands
	while #tb do
		local commandClassRef = table.remove(tb, tb[#tb])
		local commandInstance = commandClassRef.new()
		commandInstance:execute(notification)
	end
end

return MacroCommand