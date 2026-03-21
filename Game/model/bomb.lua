Bomb = Item:extend()

function Bomb:new(x,y)
    Bomb.super.new(self,x,y)
    self.occupies = true
    self.destructible = true
    self.moves = false
    self.blastRadius=1
    self.ttl = 5

    local grid = anim8.newGrid(16,16,sprites:getWidth(),sprites:getHeight(),0,0,0)
    self.animation = anim8.newAnimation(grid(5,"5-3"),0.2)
end

function Bomb:update(dt)
    Bomb.super.update(self,dt)
    self.animation:update(dt)
    self.ttl = self.ttl - dt
    if self.ttl <= 0 then
        self:explode()
    end
end

function Bomb:draw()
    Bomb.super.draw()
    love.graphics.push()
    love.graphics.scale(128 / 16, 128 / 16)
    self.animation:draw(sprites,0,0)
    love.graphics.pop()
end

function Bomb:explode()
    --we have to destroy ourselves to ensure that the place is empty.
    self.level:destroyItem(self)
    self.level:spawnItem(Explosion,self:getX(),self:getY())
    for r=1,self.blastRadius do
        self.level:spawnItem(Explosion,self:getX()+r,self:getY())
        self.level:spawnItem(Explosion,self:getX(),self:getY()+r)
        self.level:spawnItem(Explosion,self:getX()-r,self:getY())
        self.level:spawnItem(Explosion,self:getX(),self:getY()-r)
    end
end

Explosion = Item:extend()

function Explosion:new(x,y)
    Explosion.super.new(self,x,y)
    self.occupies = false
    self.destructible = false
    self.moves = false
    self.killsOnContact = true
    self.ttl = 2
end

function Explosion:update(dt)
    self.ttl = self.ttl - dt
    if self.ttl < 0 then
        self.level:destroyItem(self)
    else
        local items = tableExt.copy(self.level.map[self:getY()][self:getX()])
        for i,item in ipairs(items) do
            if item.destructible or item.canDie then
                self.level:destroyItem(item)
            end
        end
    end
end
