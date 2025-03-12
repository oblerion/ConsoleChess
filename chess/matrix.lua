
require("chess.piece")
---@class piece_type : Piece_type
local piece_type = require("chess.piece_type")
---@class piece_moves : Piece_moves
local piece_moves = require("chess.piece_moves")

  ---@class Matrix
  local matrix = {
    w=0,
    h=0,
    matrix = {}
  }
  ---@param w integer
  ---@param h integer
  function matrix:Init(w,h)
    self.w = w
    self.h = h
    self.matrix={}
    for i=1,self.h do
      self.matrix[i] = {}
      for j=1,self.w do
        --,team,piece
        self.matrix[i][j] = Piece(0,0)
      end
    end
  end
  ---@param x integer
  ---@param y integer
  ---@return boolean
  function matrix:InLimit(x,y)
    if x>0 and x<=self.w and y>0 and y<=self.h then
      return true
    end
    return false
  end
  ---@param x integer
  ---@param y integer
  ---@return boolean
  function matrix:IfExist(x,y)
    if self:InLimit(x,y) then
      return self.matrix[y][x]:IfExist()
    end
    return false
  end
  ---@param x integer
  ---@param y integer
  ---@return Piece
  function matrix:GetTable(x,y)
    if self:InLimit(x,y) then
      return self.matrix[y][x]
    end
    return Piece(0,0)
  end
  ---@param x integer
  ---@param y integer
  ---@param t Piece
  function matrix:SetTable(x,y,t)
    self.matrix[y][x]:SetId(t:GetId())
    self.matrix[y][x]:SetTeam(t:GetTeam())
    self.matrix[y][x]:SetDirect(t:GetDirect())
  end
  ---@param x integer
  ---@param y integer
  function matrix:Remove(x,y)
    self.matrix[y][x]:SetId(0)
    self.matrix[y][x]:SetTeam(0)
  end
  ---@param x integer
  ---@param y integer
  ---@return integer
  function matrix:GetId(x,y)
    if self:InLimit(x,y) then
      return self.matrix[y][x]:GetId()
    end
    return 0
  end
  ---@param x integer
  ---@param y integer
  ---@param id integer
  ---@return integer
  function matrix:SetId(x,y,id)
    if self:InLimit(x,y) then
      self.matrix[y][x]:SetId(id)
    end
    return 0
  end
  ---@param x integer
  ---@param y integer
  ---@return integer
  function matrix:GetTeam(x,y)
    if self:InLimit(x,y) then
      return self.matrix[y][x]:GetTeam()
    end
    return 0
  end
  ---@param x integer
  ---@param y integer
  ---@param id integer
  ---@return integer
  function matrix:SetTeam(x,y,id)
    if self:InLimit(x,y) then
      self.matrix[y][x]:SetTeam(id)
    end
    return 0
  end
  ---@param mx integer
  ---@param my integer
  ---@return integer,integer
  function matrix:GetPos(mx,my)
    local x = math.floor((mx-16)/(4*16))
    local y = math.floor((my-16)/16)
    return x,y
  end
  ---@param x integer
  ---@param y integer
  ---@return string
  function matrix:Draw(x,y)
    if self:InLimit(x,y) then
      return self.matrix[y][x]:Draw()
    end
    return " "
  end
  ---@param x integer
  ---@param y integer
  ---@param tag string
  ---@param team integer
  function matrix:InitCell(x,y,tag,team)
    local id =  piece_type:GetId(tag)--self:_piece_getId(tag)
    self:SetId(x,y,id)
    self:SetTeam(x,y,team)
    -- set direction
    if y==self.h or y==self.h-1 then
      self.matrix[y][x].direct=-1
    elseif y==1 or y==2 then
      self.matrix[y][x].direct=1
    end
  end
  ---@param x integer
  ---@param y integer
  ---@param x2 integer
  ---@param y2 integer
  ---@return boolean
  function matrix:IsEnemy(x,y,x2,y2)
    local team = self:GetTeam(x,y)
    local team2 = self:GetTeam(x2,y2)
    if team==0 or team2==0 then return false end
    if not(team==team2) then return true end
    return false
  end
  ---@param x integer
  ---@param y integer
  ---@param x2 integer
  ---@param y2 integer
  function matrix:Move(x,y,x2,y2)
    --if self:IfExist(x,y) then
      local t = self:GetTable(x,y)
      self:SetTable(x2,y2,t)
      self:Remove(x,y)
    --end
  end
  ---@param team integer
  ---@return table
  function matrix:GetAllMoves(team)
    local list = {}
    for y=1,self.h do
      for x=1,self.w do
        local piece = self:GetTable(x,y)
        if piece:IfExist() and piece:GetTeam()==team then
          piece_moves:InitMoves(self,x,y)
        end
      end
    end
    local moves = piece_moves:GetMoves()
    for _,v in pairs(moves) do
      table.insert(list,v)
    end
    piece_moves:Reset()
    return list
  end

  return matrix
