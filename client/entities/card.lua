local Card = Class('Card')

function Card:initialize(rank, suit)
	self.gui = GS.current().gui

	self.rank = rank
	self.suit = suit

	self.selected = false
end

function Card:update(ox, oy)
	ox = ox - 30
	---- lúc chơi thì and oy - 40 thôi, đang debug nên -75 để thấy bài cho rõ
	oy = self.selected and oy - 75 or oy

	if self.gui:Button(tostring(self.rank)..':'..tostring(self.suit),
			ox , oy, 80, 100).hit then
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