Player = Item:extend()

function Player:new(x,y)
    Player.super.new(self,x,y)
    self.moves = true
    self.destructible = true
    self.occupies = true

    local grid = anim8.newGrid(9,14,sprites:getWidth(),sprites:getHeight(),0,33)
    self.animation_idle = anim8.newAnimation(grid(1,'1-2'),0.6)
end

function Player:update(dt)
    Player.super.update(self, dt)
    self.animation_idle:update(dt)
end

function Player:draw()
    --   self.anim:draw(self.spritesheet, self.x, self.y, nil, game.scale)
    love.graphics.push()
    love.graphics.scale(8,8)
    self.animation_idle:draw(sprites,2,2)
    love.graphics.pop()
end    

function Player:moveRight()
    self.level:moveItem(self,1,0)
end

function Player:moveDown()
    self.level:moveItem(self,0,1)
end

function Player:moveLeft()
    self.level:moveItem(self,-1,0)
end

function Player:moveUp()
    self.level:moveItem(self,0,-1)
end

function Player:placeBomb()
    local bomb=self.level:ItemDropsItem(self,Bomb)
end