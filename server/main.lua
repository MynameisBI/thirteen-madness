require 'globals'

socket = require 'socket'

udp = socket.udp()
udp:settimeout(0)
udp:setsockname('*', 12345)

local players = {}

local currentCombination = Combinations.single
local currentPlayerIndex = 1

local running = true

print('Begin server loop...')
while running do
	local data, ip, port = udp:receivefrom()
	if data then
		index, command, params = data:match("^(%S*) (%S*) (.*)")

		if command == 'join' then
			print('add player')

		else
			print("unrecognised command:", cmd)
		end

	elseif ip ~= 'timeout' then
		error("Unknown network error: "..tostring(msg))
	end

	socket.sleep(0.01)
end




