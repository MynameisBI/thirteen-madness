require 'globals'
socket = require 'socket'

---- Networking ----
udp = socket.udp()
udp:settimeout(0)
udp:setsockname('*', 12345)


---- Game managing ----
local players = {}

local roundCombination, roundStrongestCard, roundSequenceLength
local currentPlayerTurnIndex = 1


---- Main functions ----
local player = Player()
player:addCard(Card(CardRank.Ace, CardSuit.Spades))
player:addCard(Card(CardRank.Three, CardSuit.Spades))
player:addCard(Card(CardRank.Seven, CardSuit.Diamonds))
player:addCard(Card(CardRank.Seven, CardSuit.Clubs))
player:addCard(Card(CardRank.King, CardSuit.Hearts))
for i = 1, 5 do
	print(tostring(player.cards[i].rank)..':'..tostring(player.cards[i].suit))
end

function updateGameState()

end



---- Server loop ----
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




