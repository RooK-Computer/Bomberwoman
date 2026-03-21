Object = require "lib/classic"
require "util/tableExt"
sti = require 'lib/sti' -- simple tiled loader for maps
anim8 = require 'lib/anim8'
sprites = love.graphics.newImage('assets/sprites.png')
sprites:setFilter("nearest", "nearest", 1)
sprites:setWrap("clampzero", "clampzero")

local push = require "lib/push"
local windowWidth, windowHeight = love.window.getDesktopDimensions()
push:setupScreen(1920, 1080, windowWidth, windowHeight, {fullscreen = true})

require "model"

LoadedLevel = sti("maps/bomberplane.lua",{},0,184)
LoadedLevel:resize(1920,1080)

CurrentLevel = Level(LoadedLevel)

CurrentLevel:print()


CurrentLevel:spawnItem(Bomb(3,3))
CurrentLevel:spawnItem(Player(15,1))

function love.update(dt)
    CurrentLevel:update(dt)
end

function love.draw()
    push:start()

    CurrentLevel:draw()

    push:finish()
end

function love.keypressed(keycode)
    if keycode == "q" then
      love.event.quit(0)
    end
end