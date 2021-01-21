Sprites = {}

---- Import images
Sprites.cards = {}

-- Placeholder image
Sprites.cards.default = love.graphics.newImage('assets/cards/default.png')

-- Specific images
for r = 1, 13 do
	for s = 1, 4 do
		Sprites.cards[tostring(r)..'-'..tostring(s)] = Sprites.cards.default
	end
end

local cardImageFiles = love.filesystem.getDirectoryItems('assets/cards/')
for i, file in ipairs(cardImageFiles) do
	local cardCode = file:match('(%d*%-%d*)')
	if cardCode ~= nil then
		Sprites.cards[cardCode] = love.graphics.newImage('assets/cards/'..file)
	end
end