require 'globals'

local address, port = '192.168.100.10', 12345

local Menu = require 'gamestates.menu'
local Game = require 'gamestates.game'

function love.load()
	GS.switch(Menu)
	GS.registerEvents()
end

function love.update(dt)

end

function love.draw()

end

function love.keypressed(key)

end

