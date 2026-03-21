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

require "util/stack"
require "util/input/inputmanager"
require 'gameinput'

require "gametimer"
require "components/hurryup"

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

Components = {}

timer = GameTimer(function()
    local comp = HurryUp(CurrentLevel)
    table.insert(Components,comp)
end)


function love.update(dt)
    CurrentLevel:update(dt)
    timer:update(dt)
    local toDelete={}
    for i,comp in ipairs(Components) do
        comp:update(dt)
        if comp.done then
            table.insert(toDelete,comp)
        end
    end
    for i,comp in ipairs(toDelete) do
        local idx = tableExt.find(Components,comp)
        table.remove(Components,idx)
    end
end

function love.draw()
    push:start()

    CurrentLevel:draw()
    love.graphics.push()
    love.graphics.translate(92,92)
    timer:draw()
    love.graphics.pop()

    for i,comp in ipairs(Components) do
        comp:draw()
    end

    push:finish()
end
