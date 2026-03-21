HurryWall = Wall:extend()

function HurryWall:new(x,y)
    HurryWall.super.new(self,x,y)
    self.destructible = false
    self.moves = false
    self.occupies = true
    self.killsOnContact = true

    self.sprite = love.graphics.newImage("maps/tiles/desert.png")
    self.sprite:setFilter("nearest","nearest",1)
    self.sprite:setWrap("clampzero","clampzero")
    local grid = anim8.newGrid(32,32,self.sprite:getWidth(),self.sprite:getHeight(),0,0,1)
    self.animation = anim8.newAnimation(grid(8,4),1.0)
    return self
end

function HurryWall:update(dt)
    self.animation:update(dt)
    local items = tableExt.copy(self.level.map[self:getY()][self:getX()])
    for i,item in ipairs(items) do
        if item.destructible or item.canDie then
            self.level:destroyItem(item)
        end
    end
end

function HurryWall:draw()
    love.graphics.push()
    love.graphics.scale (128 / 32, 128 / 32)
    self.animation:draw(self.sprite,0,0)
    love.graphics.pop()
end