Item = Object:extend()

function Item:new(x,y)
    self.x=x
    self.y=y
    self.destructible=true
    self.moves=false
    self.occupies=false
end

function Item:getX()
    return self.x
end

function Item:getY()
    return self.y
end

function Item:isDestructible()
    return self.destructible
end

function Item:canMove()
    return self.moves
end

function Item:Occupies()
    return self.occupies
end