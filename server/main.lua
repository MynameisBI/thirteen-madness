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

math.randomseed(os.time())


---- GUI ----
local suit = Suit.new()

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


---- Server loop ----
function love.update(dt)
	---- Receiving ----
	repeat
		local data, ip, port = UDP:receivefrom()
		if data then
			local command, index, params = data:match("^(%S*) (%S*) (.*)")


			---- join ----
			if command == 'join' then
				local playerName = params:match('(%S*)')
				print(playerName..' has joined')

				local player = Player(playerName, ip, port)
				table.insert(players, player)

				if #players <= 4 then
					UDP:sendto(
						string.format('%s %d', 'confirmJoint', #players),
						ip, port
					)

				elseif #players > 4 then
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


	---- GUI ----
	if #players >= 1 then
		if suit:Button('START GAME', 10, 10, 100, 30).hit then
			startGame()
		end
	end
end

---- Start game
function startGame()
	local deck = createDeck()

	for i = 1, 13 do
		for j = 1, #players do
			local cardIndex = math.random(1, #deck)
			local card = deck[cardIndex]
			table.remove(deck, cardIndex)

			UDP:sendto(
				string.format('%s %d %d', 'addCard', card.rank, card.suit),
				players[j].ip, players[j].port
			)
		end
	end
end

function createDeck()
	local deck = {}

	for rank = 1, 13 do
		for suit = 1, 4 do
			local card = Card(rank, suit)
			table.insert(deck, card)
		end
	end

	return deck
end


function love.draw()
	suit:draw()
end