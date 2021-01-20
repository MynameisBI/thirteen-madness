local Game = require 'gamestates.game'

local Menu = {}

local SW, SH = love.graphics.getDimensions()

function Menu:enter()
	self.suit = Suit.new()

	self.name = {text = ''}
	self.serverIp = {text = '192.168.100.10'}
	self.index = nil
end

function Menu:update(dt)

	---- Connect ----
	self.suit:Label('Server IP', {align = 'left'}, SW/2 - 110, SH/2 - 60, 160, 30)
	self.suit:Input(self.serverIp, {id = 100},
			SW/2 - 30, SH/2 - 60, 160, 30)

	self.suit:Label('Name', {align = 'left'}, SW/2 - 110, SH/2 - 10, 160, 30)
	self.suit:Input(self.name, {id = 101},
			SW/2 - 30, SH/2 - 10, 160, 30)

	if self.suit:Button('JOIN', SW/2 - 60, SH/2 + 40, 120, 30).hit then
		UDP = socket.udp()
		UDP:settimeout(0)
		UDP:setpeername(self.serverIp.text, 12345)

		local dg = string.format('%s %d %s', 'join', 0, self.name.text)
		UDP:send(dg)
	end


	if UDP == nil then return end


	---- Send ----



	---- Receive ----
	repeat
		local data, msg = UDP:receive()
		if data then
			local command, params = data:match('^(%S*) (.*)')

			if command == 'confirmJoint' then
				local index = params:match('%d')
				index = tonumber(index)

				if index == 0 then
					print('room is full')
				elseif 1 <= index and index <= 4 then
					GS.switch(Game, index)
				end

			else
				print('unrecognized command: '..tostring(command))
			end
		end
	until not data

end

function Menu:draw()
	self.suit:draw()
end

function Menu:textinput(t)
	self.suit:textinput(t)
end

function Menu:keypressed(key)
	self.suit:keypressed(key)
end

return Menu