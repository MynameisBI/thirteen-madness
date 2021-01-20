require 'globals'

local Menu = require 'gamestates.menu'
local Game = require 'gamestates.game'

function love.load()
	GS.switch(Menu)
	GS.registerEvents()
end

function love.update(dt)

end

function love.draw()
	if GS.current() == Menu then
		love.graphics.print('menu')
	elseif GS.current() == Game then
		love.graphics.print('game')
	end
end

function love.keypressed(key)

end

function keyfromvalue(t, v_)
	for k, v in pairs(t) do
		if v == v_ then
			return k
		end
	end
end