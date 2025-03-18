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
    ---@param vec2 Vector
    ---@return boolean
    function vec:Collide(vec2)
        if self.x<vec2.x+vec2.x2 and 
        self.x+self.x2>vec2.x and
        self.y<vec2.y+vec2.y2 and 
        self.y+self.y2>vec2.y then 
            return true
        end
        return false
    end
    return vec
end