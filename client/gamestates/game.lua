local Game = {}

local ScreenWidth, ScreenHeight = love.graphics.getDimensions()
local DistBetweenCards = 45

function Game:enter(from, index)
	print('join game')

	self.gui = Suit.new()

	self.index = index

	self.cards = {}
	self.selectedCardIndexes = {}

	self.currentPlayerTurnIndex = nil
	self.roundCombination = nil
	self.roundStrongestCard = nil
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


			else
				print('unrecognized command: '..tostring(command))
			end
		end
	until not data


	---- Normal stuff ----
	for i = #self.cards, 1, -1 do
		self.cards[i]:update(
			ScreenWidth/2 + DistBetweenCards * (-#self.cards/2 + (i-1)),
			ScreenHeight - 120
		)
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

return Game