require 'globals'
socket = require 'socket'

---- Networking ----
UDP = socket.udp()
UDP:settimeout(0)
UDP:setsockname('*', 12345)


---- Game managing ----
local players = {}

local roundCombination, roundStrongestCard, roundSequenceLength
local currentPlayerTurnIndex = 1


---- Main functions ----
--[[
local player = Player()
player:addCard(Card(CardRank.Ace, CardSuit.Spades))
player:addCard(Card(CardRank.Three, CardSuit.Spades))
player:addCard(Card(CardRank.Seven, CardSuit.Diamonds))
player:addCard(Card(CardRank.Seven, CardSuit.Clubs))
player:addCard(Card(CardRank.King, CardSuit.Hearts))
for i = 1, 5 do
	print(tostring(player.cards[i].rank)..':'..tostring(player.cards[i].suit))
end
]]--

function updateGameState()

end



---- Server loop ----
function love.update(dt)
	repeat
		local data, ip, port = UDP:receivefrom()
		if data then
			local command, index, params = data:match("^(%S*) (%S*) (.*)")

			if command == 'join' then
				local playerName = params:match('(%S*)')
				print(playerName..' has joined')

				if #players < 4 then
					UDP:sendto(
						string.format('%s %d', 'confirmJoint', #players+1),
						ip, port
					)

				elseif #players >= 4 then
					UDP:sendto(
						string.format('%s %d', 'confirmJoint', 0),
						ip, port
					)
				end

			else
				print("unrecognised command:", cmd)
			end

		elseif ip ~= 'timeout' then
			error("Unknown network error: "..tostring(msg))
		end
	until not data

	socket.sleep(0.02)
end

