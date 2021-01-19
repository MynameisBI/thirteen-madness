local Player = Class('Player')

function Player:initialize(name, ip, port)
	self.name = name
	self.ip = ip
	self.port = port

	self.isReady = false

	self.cards = {}
	self.isPassedThisRound = false
end

function Player:toggleReady()
	self.isReady = not self.isReady
end

function Player:addCard(card)
	table.insert(self.cards, card)
	table.sort(self.cards)
end

return Player