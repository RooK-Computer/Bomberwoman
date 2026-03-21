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
require 'gameinput'

inputManager = InputManager()

LoadedLevel = sti("maps/bomberplane.lua",{},0,184)
LoadedLevel:resize(1920,1080)

CurrentLevel = Level(LoadedLevel)

CurrentLevel:print()


Players = {
    Player(1,1),
    Player(15,1),
    Player(15,7),
    Player(1,7)
}

UnoccupiedPlayers = Stack()
UnoccupiedPlayers:push(Players[4])
UnoccupiedPlayers:push(Players[3])
UnoccupiedPlayers:push(Players[2])
UnoccupiedPlayers:push(Players[1])

for idx,player in ipairs(Players) do
    CurrentLevel:spawnItem(player)
end

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
