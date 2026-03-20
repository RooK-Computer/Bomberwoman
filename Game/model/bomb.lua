Bomb = Item:extend()

function Bomb:new(x,y)
    Bomb.super.new(self,x,y)
    self.occupies = true
    self.destructible = true
    self.moves = false
    self.blastRadius=1
    self.ttl = 15
end

function Bomb:update(dt)
    Bomb.super.update(self,dt)
    self.ttl = self.ttl - dt
    if self.ttl <= 0 then
        -- TODO: time to explode!
    end
end

Explosion = Item:extend()

function Explosion:new(x,y)
    Explosion.super.new(self,x,y)
    self.occupies = false
    self.destructible = false
    self.moves = false
end
