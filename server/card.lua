local Card = Class('Card')

function Card:initialize(rank, suit)
	self.rank = rank
	self.suit = suit
end

function Card:__lt(other)
	assert(
		not (self.rank == other.rank and self.suit == other.suit),
		string.format('Duplicate card. Card code: %s:%s', tostring(self.rank), tostring(self.suit))
	)

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