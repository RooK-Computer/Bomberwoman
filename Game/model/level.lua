Level = Object:extend()

function Level:new()
    self.map = {}
    self.items = {}
    for y=1,7 do
        self.map[y] = {}
        for x=1,15 do
            self.map[y][x]={}
        end
    end
    for y=2,6,2 do
        for x=2,14,2 do
            local wall = Wall(x,y)
            wall.level=self
            table.insert(self.items,wall)
            self.map[y][x][1]=wall
        end
    end
    self:fillWithRubble()
    return self
end

function Level:isOccupied(x,y)
    for idx,item in ipairs(self.map[y][x]) do
        if item:Occupies() then
            return true
        end
    end
    return false
end

function Level:fillWithRubble()
    local clearCoordinates ={
        {1,1},
        {1,2},
        {2,1},
        {15,1},
        {14,1},
        {15,2},
        {1,7},
        {1,6},
        {2,7},
        {15,7},
        {14,7},
        {15,6}
    }
    for y=1,7 do
        for x=1,15 do
            if self:isOccupied(x,y) == false then
                local fill=true
                for idx,coords in ipairs(clearCoordinates) do
                    if x==coords[1] and y==coords[2] then
                        fill=false
                    end
                end
                if fill then
                    local rubble = Rubble(x,y)
                    rubble.level = self
                    table.insert(self.items,rubble)
                    self.map[y][x][1] = rubble
                end
            end
        end
    end
end

function Level:print()
    for y=1,7 do
        local line=""
        for x=1,15 do
            if #self.map[y][x] == 0 then
                line = line.."."
            elseif self.map[y][x][1]:is(Player) then
                line = line.."x"
            elseif self.map[y][x][1]:isDestructible() then
                line = line.."/"
            else 
                line = line.."#"
            end
        end
        print(line)
    end
end

function Level:update(dt)
    for idx,item in ipairs(self.items) do
        item:update(dt)
    end
end