Component = Object:extend()

function Component:new(level)
    self.level = level
    self.done = false
end

function Component:update(dt)
end

function Component:draw()
end