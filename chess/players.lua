
require "chess.player"

---@class Players
local players = {
  list = {},
  curant=1
}

function players:Reset()
  self.list = {}
  self.curant = 1
end
---@param team integer
---@param type string
function players:Add(team,type)
  table.insert(self.list,Player(team,type))--{team=team,type=type})
end
---@return integer
function players:GetNb()
  return #self.list
end
---@return integer
function players:GetCurantTeam()
  if #self.list==0 then return 0 end
  return self.list[self.curant]:GetTeam()--.team
end
---@return string
function players:GetCurantType()
  if #self.list==0 then return "" end
  return self.list[self.curant]:GetType()
end

function players:NextPlayer()
  if(self.curant+1 <= #self.list) then
    self.curant = self.curant+1
  else 
    self.curant = 1
  end
end

return players
