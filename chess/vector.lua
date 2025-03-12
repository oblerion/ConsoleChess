---@param x integer
---@param y integer
---@param x2 integer
---@param y2 integer
function Vector(x,y,x2,y2)
    ---@class Vector
    local vec = {x=x,y=y,x2=x2,y2=y2}
    ---@return integer
    function vec:Dis()
        return math.abs(self.x2-self.x) + math.abs(self.y2-self.y)
    end
    return vec
end