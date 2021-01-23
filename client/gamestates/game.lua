local Game = {}

local ScreenWidth, ScreenHeight = love.graphics.getDimensions()
local DistBetweenCards = 45

function Game:enter(from, index)
	self.gui = Suit.new()

	self.index = index

	self.cards = {}

	self.currentPlayerTurnIndex = nil
	self.roundCombination = nil
	self.roundStrongestCard = nil
	self.roundSequenceLength = 0
	self.playersCardLeft = {0, 0, 0, 0}
end

function Game:update(dt)
	---- Send ----



	---- Receive ----
	repeat
		local data, msg = UDP:receive()
		if data then
			local command, params = data:match('^(%S*) (.*)')

			if command == 'addCard' then
				local rank, suit = params:match('^(%d*) (%d*)')
				rank, suit = tonumber(rank), tonumber(suit)
				self:addCard(rank, suit)

			elseif command == 'update' then
				print(params)
				local currentPlayerTurnIndex, roundCombination, roundSequenceLength, roundStrongestCardId, playersCardLeft =
						params:match('^(%d*) (%S*) (%S*) (%S*%-%S*) (%d*%-%d*%-%d*%-%d*)')

				self.currentPlayerTurnIndex = tonumber(currentPlayerTurnIndex)

				self.roundCombination = tonumber(roundCombination)

				self.roundSequenceLength = roundSequenceLength

				local rank, suit = roundStrongestCardId:match('^(%d)%-(%d)')
				self.roundStrongestCard = rank == nil and nil or Card(rank, suit)

				self.playersCardLeft[1], self.playersCardLeft[2], self.playersCardLeft[3], self.playersCardLeft[4] =
						playersCardLeft:match('^(%d)%-(%d)%-(%d)%-(%d)')

			else
				print('unrecognized command: '..tostring(command))
			end
		end
	until not data


	---- Normal stuff ----
	for i = #self.cards, 1, -1 do
		self.cards[i]:update(
			ScreenWidth/2 - 60 + DistBetweenCards * (-#self.cards/2 + (i-1)),
			ScreenHeight - 140
		)
	end

	if self.gui:Button('Play', ScreenWidth - 115, ScreenHeight - 70, 100, 40).hit then
		if self.index ~= self.currentPlayerTurnIndex then
			print("it's not your turn")
		else
			self:playSelectedCards()
		end
	end
end

function Game:draw()
	self.gui:draw()
end

function Game:addCard(rank, suit)
	local card = Card(rank, suit)
	table.insert(self.cards, card)
	table.sort(self.cards)
end

function Game:playSelectedCards()
	local selectedCards = {}
	for i = 1, #self.cards do
		if self.cards[i].selected then
			table.insert(selectedCards, self.cards[i])
		end
	end

	local combination = self:getCombination(selectedCards)
	if combination then
		print('is valid')
	end
end

function Game:getCombination(cards)
	table.sort(cards)

	if #cards == 1 then
		return Combinations.Single

	elseif #cards == 2 and cards[1].rank == cards[2].rank then
		return Combinations.Double

	elseif #cards == 3 and cards[1].rank == cards[2].rank and
			cards[1].rank == cards[3].rank then
		return Combinations.Triple

	elseif #cards == 4 and cards[1].rank == cards[2].rank and
			cards[1].rank == cards[3].rank and cards[1].rank == cards[4].rank then
		return Combinations.Quadruple

	elseif #cards >= 3 then
		for i = 1, #cards-1 do
			if cards[i+1].rank - cards[i].rank ~= 1 then
				return false
			end
		end
		return Combinations.Sequence

	elseif #cards >= 6 and #cards % 2 == 0 then
		for i = 1, #cards / 2 do
			if cards[i*2-1].rank ~= cards[i*2] then
				return false
			end
		end

		for i = 1, #cards / 2 - 1 do
			if cards[i*2+1].rank - cards[i*2].rank then
				return false
			end
		end

		return Combinations.DoubleSequence

	else
		return false
	end
end

return Game