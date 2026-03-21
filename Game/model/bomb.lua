Bomb = Item:extend()

function Bomb:new(x,y,onDestroy)
    Bomb.super.new(self,x,y)
    self.occupies = true
    self.destructible = true
    self.moves = false
    self.blastRadius=1
    self.ttl = 2
    self.exploding = false
    self.onDestroy = onDestroy

    local grid = anim8.newGrid(16,16,sprites:getWidth(),sprites:getHeight(),0,0,0)
    self.animation = anim8.newAnimation(grid(5,"5-3",5,"3-5"),0.2)
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

function Bomb:Destroy()
    if not self.exploding then
      self:explode()
    end
    self.onDestroy()
end

function Bomb:explode()
    self.exploding = true
    --we have to destroy ourselves to ensure that the place is empty.
    self.level:destroyItem(self)
    self.level:spawnItem(Explosion("center",0,self:getX(),self:getY()))
    for r=1,self.blastRadius do
        local type = "middle"
        if r == self.blastRadius then 
            type = "end"
        end
        self.level:spawnItem(Explosion(type,math.rad(180),self:getX()+r,self:getY()))
        self.level:spawnItem(Explosion(type,math.rad(-90),self:getX(),self:getY()+r))
        self.level:spawnItem(Explosion(type,0,self:getX()-r,self:getY()))
        self.level:spawnItem(Explosion(type,math.rad(90),self:getX(),self:getY()-r))
    end
end

Explosion = Item:extend()

function Explosion:new(location,rotation,x,y)
    Explosion.super.new(self,x,y)
    self.occupies = false
    self.destructible = false
    self.moves = false
    self.killsOnContact = true
    self.ttl = 0.08*11
    self.rotation = rotation
    self.location = location

    local grid = anim8.newGrid(16,16,sprites:getWidth(),sprites:getHeight())
    if location == "center" then
        self.animation = anim8.newAnimation(grid(8,'8-3',8,'4-8'),0.08,function(animation,loops)
            self.ttl = 0
        end)
    elseif location == "middle" then
        self.animation = anim8.newAnimation(grid(7,"8-3",7,"4-8"),0.08,function(animation,loops)
            self.ttl = 0
        end)
    elseif location == "end" then
        self.animation = anim8.newAnimation(grid(6,"8-3",6,"4-8"),0.08,function(animation,loops)
            self.ttl = 0
        end)
    end
end

function Explosion:update(dt)
    self.animation:update(dt)
    self.ttl = self.ttl - dt
    if self.ttl < 0 then
        self.level:destroyItem(self)
    elseif self.location == "center" or self.ttl <= 0.08*11-2*0.08 then
        local items = tableExt.copy(self.level.map[self:getY()][self:getX()])
        for i,item in ipairs(items) do
            if item.destructible or item.canDie then
                self.level:destroyItem(item)
            end
        end
    end
end

function Explosion:draw()
    love.graphics.push()
    love.graphics.translate(64,64)
    love.graphics.rotate(self.rotation)
    love.graphics.scale(128 / 16, 128 / 16)
    self.animation:draw(sprites,-8,-8)
    love.graphics.pop()
end
