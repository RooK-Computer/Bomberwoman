Wall = Item:extend()

function Wall:new(x,y)
    Wall.super.new(self,x,y)
    self.destructible=false
    self.moves=false
    self.occupies=true
end
