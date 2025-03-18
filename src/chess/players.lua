
require "chess.player"
require "chess.player_ia"
require "chess.player_human"
function Players()
  ---@class Players
  local players = {
    ---@private
    ---@type Player[]
    list = {},
    ---@private
    curant=1
  }

  function players:Reset()
    self.list = {}
    self.curant = 1
  end
  ---@param team integer
  ---@param level integer
  function players:AddIa(team,level)
    local ia = Player_ia(team,level)
    table.insert(self.list,ia)
  end
  ---@param team integer
  function players:AddHuman(team)
    local human = Player_human(team)
    table.insert(self.list,human)
  end
  ---@return integer
  function players:GetNb()
    return #self.list
  end
  ---@param id integer
  ---@return Player
  function players:GetPlayer(id)
    return self.list[id]
  end
  ---@return integer
  function players:GetCurantTeam()
    if #self.list==0 then return 0 end
    return self:GetPlayer(self.curant):GetTeam()--.team
  end
  ---@return string
  function players:GetCurantType()
    if #self.list==0 then return "" end
    return self:GetPlayer(self.curant):GetType()
  end

  function players:NextPlayer()
    if(self.curant+1 <= #self.list) then
      self.curant = self.curant+1
    else 
      self.curant = 1
    end
  end
  ---@param chess Chess
  function players:Update(chess)
    if chess.checkmate:IfMathcheckmate()==false then
      local type = self:GetCurantType()
      if self.list[self.curant]:Update(chess)==true then
        self:NextPlayer()
        return 1
      end
    end
    return 0
  end

  return players
end