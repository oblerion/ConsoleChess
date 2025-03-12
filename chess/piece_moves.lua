---@class piece_type : Piece_type
local piece_type = require("chess.piece_type")

require("chess.vector")

---@class Piece_moves
local piece_moves = {
  ---@private
  list={}
}
---@private
---@param matrix Matrix
---@param x integer
---@param y integer
---@param dx integer
---@param dy integer
function piece_moves:_addMove(matrix,x,y,dx,dy)
  if matrix:InLimit(dx,dy) and 
  matrix:IfExist(dx,dy) == false then
    table.insert(self.list,Vector(x,y,dx,dy)) --{x=dx,y=dy})
  end
end
---@private
---@param matrix Matrix
---@param x integer
---@param y integer
---@param dx integer
---@param dy integer
function piece_moves:_addAttack(matrix,x,y,dx,dy)
  if matrix:InLimit(dx,dy) and 
  ( matrix:IfExist(dx,dy) and matrix:IsEnemy(x,y,dx,dy) ) then
    table.insert(self.list,Vector(x,y,dx,dy)) --{x=dx,y=dy})
  end
end
function piece_moves:Reset()
  self.list = {}
end
---@return table
function piece_moves:GetMoves()
  return self.list
end
---@private
---@param matrix Matrix
---@param x integer
---@param y integer
function piece_moves:_moves_pion(matrix,x,y)
  local d = matrix.matrix[y][x]:GetDirect()
  if d==-1 then
    if y==7 then self:_addMove(matrix,x,y,x,y-2) end
    self:_addMove(matrix,x,y,x,y-1)
    self:_addAttack(matrix,x,y,x-1,y-1)
    self:_addAttack(matrix,x,y,x+1,y-1)
  elseif d==1 then
    if y==2 then self:_addMove(matrix,x,y,x,y+2) end
    self:_addMove(matrix,x,y,x,y+1)
    self:_addAttack(matrix,x,y,x+1,y+1)
    self:_addAttack(matrix,x,y,x-1,y+1)
  end
end
---@private
---@param matrix Matrix
---@param x integer
---@param y integer
function piece_moves:_moves_cavalier(matrix,x,y)
  self:_addMove(matrix,x,y,x+2,y-1)
  self:_addMove(matrix,x,y,x-2,y-1)
  self:_addMove(matrix,x,y,x+1,y-2)
  self:_addMove(matrix,x,y,x-1,y-2)
  self:_addMove(matrix,x,y,x+2,y+1)
  self:_addMove(matrix,x,y,x-2,y+1)
  self:_addMove(matrix,x,y,x+1,y+2)
  self:_addMove(matrix,x,y,x-1,y+2)
  
  self:_addAttack(matrix,x,y,x+2,y-1)
  self:_addAttack(matrix,x,y,x-2,y-1)
  self:_addAttack(matrix,x,y,x+1,y-2)
  self:_addAttack(matrix,x,y,x-1,y-2)
  self:_addAttack(matrix,x,y,x+2,y+1)
  self:_addAttack(matrix,x,y,x-2,y+1)
  self:_addAttack(matrix,x,y,x+1,y+2)
  self:_addAttack(matrix,x,y,x-1,y+2)
end
---@private
---@param matrix Matrix
---@param x integer
---@param y integer
function piece_moves:_moves_tour(matrix,x,y)
  if x<8 then
    for i=x+1,8 do
      self:_addMove(matrix,x,y,i,y)
      self:_addAttack(matrix,x,y,i,y)
      if matrix:IfExist(i,y) then break end
      i=i+1
    end
  end
  if x>1 then
    for i=x-1,1,-1 do
      self:_addMove(matrix,x,y,i,y)
      self:_addAttack(matrix,x,y,i,y)
      if matrix:IfExist(i,y) then break end
      i=i+1
    end
  end
  if y<8 then
    for i=y+1,8 do
      self:_addMove(matrix,x,y,x,i)
      self:_addAttack(matrix,x,y,x,i)
      if matrix:IfExist(x,i) then break end
      i=i+1
    end
  end
  if y>1 then
    for i=y-1,1,-1 do
      self:_addMove(matrix,x,y,x,i)
      self:_addAttack(matrix,x,y,x,i)
      if matrix:IfExist(x,i) then break end
      i=i+1
    end
  end
end
---@private
---@param matrix Matrix
---@param x integer
---@param y integer
function piece_moves:_moves_fou(matrix,x,y)
  local i=1
  while matrix:InLimit(x+i,y+i)==true do
    self:_addMove(matrix,x,y,x+i,y+i)
    self:_addAttack(matrix,x,y,x+i,y+i)
    if matrix:IfExist(x+i,y+i) then break end
    i=i+1
  end
  i=1
  while matrix:InLimit(x-i,y-i)==true do
    self:_addMove(matrix,x,y,x-i,y-i)
    self:_addAttack(matrix,x,y,x-i,y-i)
    if matrix:IfExist(x-i,y-i) then break end
    i=i+1
  end
  i=1
  while matrix:InLimit(x+i,y-i)==true do
    self:_addMove(matrix,x,y,x+i,y-i)
    self:_addAttack(matrix,x,y,x+i,y-i)
    if matrix:IfExist(x+i,y-i) then break end
    i=i+1
  end
  i=1
  while matrix:InLimit(x-i,y+i)==true do
    self:_addMove(matrix,x,y,x-i,y+i)
    self:_addAttack(matrix,x,y,x-i,y+i)
    if matrix:IfExist(x-i,y+i) then break end
    i=i+1
  end
end
---@private
---@param matrix Matrix
---@param x integer
---@param y integer
function piece_moves:_moves_reine(matrix,x,y)
  self:_moves_tour(matrix,x,y)
  self:_moves_fou(matrix,x,y)
end
---@private
---@param matrix Matrix
---@param x integer
---@param y integer
function piece_moves:_moves_roi(matrix,x,y)
  self:_addMove(matrix,x,y,x+1,y+1)
  self:_addMove(matrix,x,y,x-1,y+1)
  self:_addMove(matrix,x,y,x+1,y-1)
  self:_addMove(matrix,x,y,x-1,y-1)
  
  self:_addMove(matrix,x,y,x+1,y+0)
  self:_addMove(matrix,x,y,x+0,y-1)
  self:_addMove(matrix,x,y,x-1,y+0)
  self:_addMove(matrix,x,y,x+0,y+1)
  
  self:_addAttack(matrix,x,y,x+1,y+1)
  self:_addAttack(matrix,x,y,x-1,y+1)
  self:_addAttack(matrix,x,y,x+1,y-1)
  self:_addAttack(matrix,x,y,x-1,y-1)
  
  self:_addAttack(matrix,x,y,x+1,y+0)
  self:_addAttack(matrix,x,y,x+0,y-1)
  self:_addAttack(matrix,x,y,x-1,y+0)
  self:_addAttack(matrix,x,y,x+0,y+1)
end
---@param matrix Matrix
---@param x integer
---@param y integer
function piece_moves:InitMoves(matrix,x,y) -- liste of move of piece
  local id = matrix:GetId(x,y)
  if id>0 then
    local tag = piece_type:GetTag(id)
    if tag=="pion" then
      self:_moves_pion(matrix,x,y)
    elseif tag=="cavalier" then
      self:_moves_cavalier(matrix,x,y)
    elseif tag=="tour" then
      self:_moves_tour(matrix,x,y)
    elseif tag=="fou" then
      self:_moves_fou(matrix,x,y)
    elseif tag=="reine" then
      self:_moves_reine(matrix,x,y)
    elseif tag=="roi" then
      self:_moves_roi(matrix,x,y)
    end
  end
end
---@param x integer
---@param y integer
---@return boolean
function piece_moves:IsMove(x,y)
  for n,v in pairs(self.list)do
    if v.x2==x and v.y2==y then
      return true
    end
  end
  return false
end

return piece_moves