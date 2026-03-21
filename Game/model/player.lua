Player = Item:extend()

function Player:new(x,y)
    Player.super.new(self,x,y)
    self.moves = true
    self.move_x = 0
    self.move_y = 0
    self.destructible = true
    self.occupies = true
    self.ttl = 1
    self.bombsInPlay = 0
    self.playableBombs = 1
    self.real_x = x * Constants.TILE_SIZE
    self.real_y = y * Constants.TILE_SIZE 
    self.real_draw_offset_x = 0
    self.real_draw_offset_y = 0

    local grid = anim8.newGrid(9,14,sprites:getWidth(),sprites:getHeight(),0,33)
    self.animation_idle = anim8.newAnimation(grid(1,'1-2'),0.6)
end

function Player:Destroy()
    self.afterLife = true
    self.playableBombs = 0
end

function Player:update(dt)
    Player.super.update(self, dt)
    if not self.afterLife then
        local delta_real_x = self.move_x * dt * Constants.VELOCITY
        local real_x_offset = self.real_draw_offset_x + delta_real_x;
        self.real_draw_offset_x = real_x_offset
        if math.abs(real_x_offset) > Constants.TILE_SIZE/2 then
            if self.level:moveItem(self,self.move_x,0) then
                self.real_draw_offset_x = -self.move_x * Constants.TILE_SIZE + real_x_offset
            else 
                self.real_draw_offset_x = self.move_x * Constants.TILE_SIZE/2
            end
        end
        local delta_real_y = self.move_y * dt * Constants.VELOCITY
        local real_y_offset = self.real_draw_offset_y + delta_real_y;
        self.real_draw_offset_y = real_y_offset
        if math.abs(real_y_offset) > Constants.TILE_SIZE/2 then
            if self.level:moveItem(self,0,self.move_y) then
                self.real_draw_offset_y = -self.move_y * Constants.TILE_SIZE + real_y_offset
            else 
                self.real_draw_offset_y = self.move_y * Constants.TILE_SIZE/2
            end
        end
    end
    if self.afterLife then
        self.ttl = self.ttl - dt
        if self.ttl < 0 then 
            self.afterLife = false
        end
    end
    self.animation_idle:update(dt)
end

function Player:draw()
    --   self.anim:draw(self.spritesheet, self.x, self.y, nil, game.scale)
    love.graphics.push()
    -- love.graphics.setColor(1,0,0,0.5)
    -- love.graphics.rectangle("fill",0,0,128,128)
    -- love.graphics.setColor(1,1,1,1)
    love.graphics.translate(self.real_draw_offset_x,self.real_draw_offset_y)
    love.graphics.scale(8,8)
    love.graphics.setColor(1,1,1,self.ttl)
    if self.afterLife then
        love.graphics.translate(0,(1-self.ttl)*-5)
    end
    print('Draf: self.real_draw_offset_x ' .. self.real_draw_offset_x)
    self.animation_idle:draw(sprites,2,2)
    love.graphics.setColor(1,1,1,1)
    love.graphics.pop()
end    

function Player:moveRight()
    self.level:moveItem(self,1,0)
end

function Player:moveDown()
    self.level:moveItem(self,0,1)
end

function Player:moveLeft()
    self.level:moveItem(self,-1,0)
end

function Player:moveUp()
    self.level:moveItem(self,0,-1)
end

function Player:placeBomb()
    if self.bombsInPlay < self.playableBombs then
        local bomb = Bomb(0,0,function()
            self.bombsInPlay = self.bombsInPlay - 1
        end)
        local bomb=self.level:ItemDropsItem(self,bomb)
        self.bombsInPlay = self.bombsInPlay + 1
    end
end