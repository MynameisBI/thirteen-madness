local Card = Class('Card')

function Card:initialize(rank, suit)
	self.gui = GS.current().gui

	self.rank = rank
	self.suit = suit
	self.id = tostring(self.rank)..'-'..tostring(self.suit)

	self.selected = false
end

function Card:update(ox, oy)
	ox = ox - 35
	---- lúc choi thì and oy - 50 thôi, đang debug nên -75 đe thấy bài cho rõ
	oy = self.selected and oy - 50 or oy

	---- For code debugging
	--[[
	if self.gui:ImageButton(tostring(self.rank)..'-'..tostring(self.suit),
			ox, oy, 80, 110).hit then
		self:toggleSelection()
	end
	]]--

	---- For art debugging
	if self.gui:ImageButton(Sprites.cards[tostring(self.rank)..'-'..tostring(self.suit)],
			{id = self.id}, ox, oy).hit then
		self:toggleSelection()
	end
end

function Card:draw()
	self.gui:draw()
end

function Card:toggleSelection()
	self.selected = not self.selected
end

function Card:__lt(other)
	--assert(
		--not (self.rank == other.rank and self.suit == other.suit),
		--string.format('Duplicate card. Card code: %s:%s', tostring(self.rank), tostring(self.suit))
	--)

	if self.rank < other.rank then
		return true

	elseif self.rank == other.rank then
		if self.suit < other.suit then
			return true
		elseif self.suit == other.suit then
			return false
		end

	elseif self.rank > other.rank then
		return false
	end
end

return Card