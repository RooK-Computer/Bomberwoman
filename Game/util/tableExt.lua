
tableExt={}

tableExt.find = function(table,object)
    for i,v in pairs(table) do
        if v == object then
            return i
        end
    end
end

tableExt.copy = function(table)
    local clone = {}
    for k,v in pairs(table) do
        clone[k] = v
    end
    return clone
end