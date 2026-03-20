Object = require "lib/classic"
require "util/tableExt"
sti = require 'lib/sti' -- simple tiled loader for maps

require "model"

LoadedLevel = sti("maps/bomberplane.lua",{},0,184)

CurrentLevel = Level(LoadedLevel)

CurrentLevel:print()

function love.update(dt)
    CurrentLevel:update(dt)
end

function love.draw()
    LoadedLevel:draw()
end

function love.keypressed(keycode)
    if keycode == "q" then
      love.event.quit(0)
    end
end