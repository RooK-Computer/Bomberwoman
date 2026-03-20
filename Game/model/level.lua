Level = Object:extend()

function Level:new()
    self.map = {}
    for y=1,8 do
        self.map[y] = {}
        for x=1,16 do
            self.map[y][x]=nil
        end
    end
    return self
end