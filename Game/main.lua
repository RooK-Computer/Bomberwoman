Object = require "lib/classic"
require "util/tableExt"
sti = require 'lib/sti' -- simple tiled loader for maps
anim8 = require 'lib/anim8'
sprites = love.graphics.newImage('assets/sprites.png')
sprites:setFilter("nearest", "nearest", 1)
sprites:setWrap("clampzero", "clampzero")

require "model"

LoadedLevel = sti("maps/bomberplane.lua",{},0,184)

CurrentLevel = Level(LoadedLevel)

CurrentLevel:print()

CurrentLevel:spawnItem(Bomb(3,3))

function love.update(dt)
    CurrentLevel:update(dt)
end

function love.draw()
    CurrentLevel:draw()
end

function love.keypressed(keycode)
    if keycode == "q" then
      love.event.quit(0)
    end
end