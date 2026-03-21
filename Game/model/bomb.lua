Bomb = Item:extend()

function Bomb:new(x,y)
    Bomb.super.new(self,x,y)
    self.occupies = true
    self.destructible = true
    self.moves = false
    self.blastRadius=1
    self.ttl = 5

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

function Bomb:explode()
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
    self.ttl = 1.4
    self.rotation = rotation

    local grid = anim8.newGrid(16,16,sprites:getWidth(),sprites:getHeight())
    if location == "center" then
        self.animation = anim8.newAnimation(grid(8,'6-3',8,'4-6'),0.2)
    elseif location == "middle" then
        self.animation = anim8.newAnimation(grid(7,"6-3",7,"4-6"),0.2)
    elseif location == "end" then
        self.animation = anim8.newAnimation(grid(6,"6-3",6,"4-6"),0.2)
    end
end

function Explosion:update(dt)
    self.animation:update(dt)
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

function Explosion:draw()
    love.graphics.push()
    love.graphics.translate(64,64)
    love.graphics.rotate(self.rotation)
    love.graphics.scale(128 / 16, 128 / 16)
    self.animation:draw(sprites,-8,-8)
    love.graphics.pop()
end
