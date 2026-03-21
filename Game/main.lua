Object = require "lib/classic"
require "util/tableExt"
require "constants"
sti = require 'lib/sti' -- simple tiled loader for maps
anim8 = require 'lib/anim8'
sprites = love.graphics.newImage('assets/sprites.png')
sprites:setFilter("nearest", "nearest", 1)
sprites:setWrap("clampzero", "clampzero")

local push = require "lib/push"
local windowWidth, windowHeight = love.window.getDesktopDimensions()
push:setupScreen(1920, 1080, windowWidth, windowHeight, {fullscreen = true})

require "model"

require "util/stack"
require "util/input/inputmanager"
inputManager = InputManager()

LoadedLevel = sti("maps/bomberplane.lua",{},0,184)
LoadedLevel:resize(1920,1080)

CurrentLevel = Level(LoadedLevel)

CurrentLevel:print()


CurrentLevel:spawnItem(Bomb(3,3))

currentPlayer = Player(15,1)
CurrentLevel:spawnItem(currentPlayer)

require 'gameinput'
gameInput = GameInput()
inputManager.HandlerStack:push(gameInput)





function love.update(dt)
    CurrentLevel:update(dt)
end

function love.draw()
    push:start()

    CurrentLevel:draw()

    push:finish()
end
