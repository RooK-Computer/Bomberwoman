Player = Item:extend()

function Player:new(x,y)
    Player.super.new(self,x,y)
    self.moves = true
    self.destructible = true
    self.occupies = true
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