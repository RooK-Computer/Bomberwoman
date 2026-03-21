HurryUp = Component:extend()

function HurryUp:new(level)
    HurryUp.super.new(self,level)
    self.font = love.graphics.newFont("assets/Outward_Bound_Blocky.ttf",128)
    self.fontTime=5
    self.time = 0
    self.stack = Stack()
    for y=2,7 do
        self.stack:push({1,y})
    end
    for x=2,15 do
        self.stack:push({x,7})
    end
    for y=6,1,-1 do
        self.stack:push({15,y})
    end
    for x=14,1,-1 do
        self.stack:push({x,1})
    end
end

function HurryUp:update(dt)
    self.time = self.time + dt
    self.fontTime = self.fontTime - dt
    if self.time > 0.5 then
        local coords = self.stack:pop()
        local x = coords[1]
        local y = coords[2]
        self.time = 0
        local wall = HurryWall(x,y)
        self.level:spawnItem(wall)
        if self.stack:isEmpty() then
            self.done = true
        end
    end
end

function HurryUp:draw()
    if self.fontTime > 0 then
        local width = self.font:getWidth("Hurry up!")
        love.graphics.push()
        love.graphics.translate(1920/2,1080/2)
        love.graphics.setFont(self.font)
        love.graphics.print("Hurry up!",-(width/2),-64)
        love.graphics.pop()
    end
end