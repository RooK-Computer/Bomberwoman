Object = require "lib/classic"
require "model"

CurrentLevel = Level()

CurrentLevel:print()

function love.update(dt)
    CurrentLevel:update(dt)
end

function love.draw()
    love.graphics.print("Hello World", 400, 300)
end

function love.keypressed()
    love.event.quit(0)
end