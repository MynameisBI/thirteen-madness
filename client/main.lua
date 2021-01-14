local socket = require 'socket'
local address, port = '192.168.100.10', 12345

function love.load()
	udp = socket.udp()
	udp:settimeout(0)
	udp:setpeername(address, port)
end

function love.update(dt)

end

function love.draw()
	love.graphics.print('press space to join')
end

function love.keypressed(key)
	if key == 'space' then
		local dg = string.format('%s %s %d', '', 'join', 0)
		udp:send(dg)
	end
end

