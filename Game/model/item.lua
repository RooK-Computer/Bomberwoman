Item = Object:extend()

function Item:new(x,y)
    self.x=x
    self.y=y
    self.destructible=true
    self.moves=false
    self.occupies=false
    self.killsOnContact=false
    self.translateDraw=true
    self.afterLife=false
    self.level = nil
end

function Item:getX()
    return self.x
end

function Item:setX(x)
    self.x = x
end

function Item:getY()
    return self.y
end

function Item:setY(y)
    self.y = y
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

function Item:Destroy()
end

function Item:update(dt)
end

function Item:draw()
end