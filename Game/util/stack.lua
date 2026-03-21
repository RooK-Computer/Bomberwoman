
Stack = Object:extend()

function Stack:new()
    self.store={}
end

function Stack:push(thing)
    table.insert(self.store,thing)
end

function Stack:pop()
    local store = self.store
    if #store == 0 then
        error("Trying to pop from an empty stack.",1)
    end
    return table.remove(self.store,#store)
end

function Stack:peek(offset)
    local store = self.store
    return self.store[#store-offset]
end

function Stack:popUpTo(thing, includingThing)
    while self:peek(0) ~= thing do
        self:pop()
    end
    if includingThing then
        self:pop()
    end
end

function Stack:clear()
    self.store = {}
end

function Stack:isEmpty()
    return #self.store == 0
end

function Stack:size()
    return #self.store
end
