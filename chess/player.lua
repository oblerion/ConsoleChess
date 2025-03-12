---@param team integer
---@param type string
function Player(team,type)
    ---@class Player
    local player = {
      team = team, -- id 1,2
      type = type -- ia or human
    }
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
    function player:GetId()
        return self.type
    end
    return player
end