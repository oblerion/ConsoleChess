---@param team integer
---@param type string
---@return Player
function Player(team,type)
    ---@class Player
    local player = {
        ---@private
        ---@type integer
        team = team, -- id 1,2
        ---@private
        ---@type string
        type = type, -- ia or human
    }
    ---@param chess Chess
    ---@return boolean
    function player:Update(chess)
        return false
    end
    ---@return boolean
    function player:IsHuman()
        if self.type=="human" then return true end
        return false
    end
    ---@return boolean
    function player:IsIA()
        if self.type=="ia" then return true end
        return false
    end
    ---@return integer
    function player:GetTeam()
        return self.team
    end
    ---@return string
    function player:GetType()
        return self.type
    end 
    return player
end