Level = Object:extend()

function Level:new(map)
    self.map = {}
    self.levelfile = map
    self.items = {}
    for y=1,7 do
        self.map[y] = {}
        for x=1,15 do
            self.map[y][x]={}
        end
    end
    local wallsLayer = map.layers["pillars"]
    for y=1,wallsLayer.height do
        for x=1,wallsLayer.width do
            local tile = wallsLayer.data[y][x]
            if tile then
                local wall = Wall(x,y)
                wall.level=self
                self.map[y][x][1] = wall
                table.insert(self.items,wall)
            end
        end
    end
    local rubbleLayer = map.layers["rubble"]
    for y=1,rubbleLayer.height do
        for x=1,rubbleLayer.width do
            local tile = rubbleLayer.data[y][x]
            if tile then
                local rubble = Rubble(x,y)
                rubble.level = self
                self.map[y][x][1] = rubble
                table.insert(self.items,rubble)
            end
        end
    end
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

function Level:draw()
    self.levelfile:draw()
    love.graphics.push()
    love.graphics.translate(0,184)
    for idx,item in ipairs(self.items) do
        item:draw()
    end
    love.graphics.pop()
end

function Level:moveItem(item,dirX,dirY)
    --TODO check if item can die and if destination has killsOnContact item
    local newX = item:getX()+dirX
    local newY = item:getY()+dirY
    if newX < 1 or newY < 1 or newX > 15 or newY > 7 then
        return false
    end
    if self:isOccupied(newX,newY) then
        return false
    end
    local idx = tableExt.find(self.map[item:getY()][item:getX()],item)
    table.remove(self.map[item:getY()][item:getX()],idx)
    item:setX(newX)
    item:setY(newY)
    table.insert(self.map[newY][newX],item)
    return true
end

function Level:ItemDropsItem(item,dropType)
    local x = item:getX()
    local y = item:getY()
    local item = dropType(x,y)
    item.level = self
    table.insert(self.items,item)
    table.insert(self.map[y][x],item)
    return item
end

function Level:spawnItem(itemType,x,y)
    --the rules are as follows:
    --if the place is occupied, check the killing tables
    --to check that, we have to create the item first
    local item = itemType(x,y)
    local placeable = true
    if self:isOccupied(x,y) then
        if item.killsOnContact then
            if self.map[y][x][1].canDie or self.map[y][x][1].destructible then
                placeable = true
            else
                placeable = false
            end     
        end
    end
    if placeable then
        table.insert(self.map[y][x],item)
        table.insert(self.items,item)
        item.level=self
    end
end

function Level:destroyItem(item)
    if item:is(Rubble) then
        self.levelfile:setLayerTile("rubble",item:getX(),item:getY(),nil)
    end
    local idx = tableExt.find(self.map[item:getY()][item:getX()],item)
    table.remove(self.map[item:getY()][item:getX()],idx)
    idx = tableExt.find(self.items,item)
    table.remove(self.items,idx)
end