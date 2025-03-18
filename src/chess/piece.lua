---@class piece_type : Piece_type
local piece_type = require("chess.piece_type")
---@class piece_moves : Piece_moves
local piece_moves = require("chess.piece_moves")

---@param id integer
---@param team integer
function Piece(id,team)
  ---@class Piece
  local piece = {
    id = id,
    team = team,
    direct = 0 -- direction for pawn
  }
  ---@return boolean
  function piece:IfExist()
    return (self.id>0 and self.team>0)
  end
  ---@return string
  function piece:GetTag()
    return piece_type:GetTag(self.id)
  end
  ---@return integer
  function piece:GetId()
    return self.id
  end
  ---@return integer
  function piece:GetTeam()
    return self.team
  end
  ---@return integer
  function piece:GetDirect()
    return self.direct
  end
  ---@param id integer
  function piece:SetId(id)
    self.id = id
  end
  ---@param team integer
  function piece:SetTeam(team)
    self.team = team
  end
  ---@param d integer
  function piece:SetDirect(d)
    self.direct = d
  end
  ---@return string
  function piece:Draw()
    return piece_type:Draw(self.id)
  end
  
  return piece
end