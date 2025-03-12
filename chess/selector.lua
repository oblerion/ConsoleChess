---@class Selector
local selector = {
  x=0,y=0,team=0,id=0,s= false
}
---@return integer,integer,integer,integer
function selector:Get()
  return self.x,self.y,self.team,self.id
end
---@param x integer
---@param y integer
---@param team integer
---@param id integer
function selector:Select(x,y,team,id)
  self.x = x
  self.y = y
  self.team = team
  self.id = id
  self.s = true
end

function selector:Deselect()
  self.x = 0
  self.y = 0
  self.s = false
end
---@return boolean
function selector:IfSelect()
  return self.s
end

function selector:DrawSelected()
  if self:IfSelect() then
    love.graphics.setColor(0,1,0.4,1)
    love.graphics.rectangle("fill",32+((self.x-1)*16*4),16+((self.y-1)*16),16,16) 
  end
end
---@param x integer
---@param y integer
function selector:DrawCursor(x,y)
  love.graphics.setColor(0,0,1,1)
  love.graphics.rectangle("fill",32+((x-1)*16*4),16+((y-1)*16),16,16)
end

---@param list table
function selector:DrawMove(list)
  love.graphics.setColor(0,1,0.4,1)
  for _,v in pairs(list) do
    local lx = 32+((v.x2-1)*16*4)
    local ly = 16+((v.y2-1)*16)
    love.graphics.rectangle("fill",lx,ly,16,16) 
  end
end
---@return integer
function selector:GetId()
  return self.id
end
---@return integer
function selector:GetTeam()
  return self.team
end
return selector