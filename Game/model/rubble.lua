Rubble = Wall:extend()

function Rubble:new(x,y)
    Rubble.super.new(self,x,y)
    self.destructible=true
    return self
end

