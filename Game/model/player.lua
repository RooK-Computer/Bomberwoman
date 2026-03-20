Player = Item:extend()

function Player:new(x,y)
    Player.super.new(self,x,y)
    self.moves = true
    self.destructible = true
    self.occupies = true
end
