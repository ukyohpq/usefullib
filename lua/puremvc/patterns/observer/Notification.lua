local Notification = class("puremvc.patterns.observer.Notification")

local private = {}


---------------------------
--@param
--@return
function Notification:ctor(name, body, type)
	self[private] = {
	   _name = name,
	   _body = body,
	   _type = type
	}
end


---------------------------
--@param
--@return
function Notification:getName()
	return self[private]._name
end


---------------------------
--@param
--@return
function Notification:setBody(body)
	self[private]._body = body
end


---------------------------
--@param
--@return
function Notification:getBody()
	return self[private]._body
end


---------------------------
--@param
--@return
function Notification:setType(type)
	self[private]._type = type
end


---------------------------
--@param
--@return
function Notification:getType()
	return self[private]._type
end


---------------------------
--@param
--@return
function Notification:toString()
	local msg = "Notification Name: " .. self:getName()
    if self[private]._body == nil then
	   msg = msg .. "\nBody:nil"
	else
	   msg = msg .. "\nBody:" .. tostring(self[private]._body)
--	   msg = msg .. "\nBody:" .. self[private]._body:toString()
	end
	
    if self[private]._type == nil then
	   msg = msg .. "\nType:nil"
	else
	   msg = msg .. "\nType:" .. self[private]._type
	end
end

return Notification