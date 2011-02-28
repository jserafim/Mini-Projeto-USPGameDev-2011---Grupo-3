-- look up for `k' in list of tables `plist'
local function search (k, plist)
    for i=1, table.getn(plist) do
        local v = plist[i][k] -- try `i'-th superclass
        if v then return v end
    end
end

function createClass (...)
    local c = {} -- new class
    
    -- class will search for each method in the list of its
    -- parents (`arg' is the list of parents)
    setmetatable(c, {__index = function (t, k)
            return search(k, arg)
        end})
    
    -- prepare `c' to be the metatable of its instances
    c.__index = c
    
    -- define a new constructor for this new class
    function c:new (o)
        o = o or {}
        setmetatable(o, c)
        for i=1, table.getn(arg) do
            local v = arg[i]["new"] 
            if v then 
                v(o) 
            end
        end
        return o
    end
    
    -- define a new destructor for this new class
    function c:destroy(o)
        for i=1, table.getn(arg) do
            local v = arg[i]["destroy"]
            if v then
                v(o)
            end
        end
    end
    
    -- return new class
    return c
end
