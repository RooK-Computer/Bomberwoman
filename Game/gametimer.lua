GameTimer = Object:extend()

function GameTimer:new(onHurryUp)
    self.elapsed = 0.0
    self.onHurryUp = onHurryUp

    self.font = love.graphics.newFont("assets/Outward_Bound_Blocky.ttf",32)
end

function GameTimer:update(dt)
    self.elapsed = self.elapsed + dt
    if self.elapsed > 90  and self.onHurryUp then
        self.onHurryUp()
        self.onHurryUp = nil
    end
end

function GameTimer:draw()
    local minutes = math.floor(self.elapsed / 60)
    local seconds = math.floor(self.elapsed % 60)
    love.graphics.setFont(self.font)
    love.graphics.print(minutes..":"..seconds)
end