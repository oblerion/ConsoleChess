---@class piece_type : Piece_type
local piece_type = require("chess.piece_type")
---@class piece_moves : Piece_moves
local piece_moves = require("chess.piece_moves")
require("chess.input")

require("chess.ia")

---@class Chess
local chess = {
  ---@class board : Board
  board= require("chess.board"),
  ---@class matrice : Matrix
  matrice= require("chess.matrix"),
  ---@class selector : Selector
  selector= require("chess.selector"),
  ---@class players : Players
  players= require("chess.players")
}

function chess:_drawCursor()
  local x,y = self.matrice:GetPos(Input_getX()+(8*1.5),Input_getY()+2)
  x =x + 1
  y =y + 1 
  if x>0 and x<=self.w and y>0 and y<=self.h then
    -- draw select
    self.selector:DrawCursor(x,y)
    if not self.selector:IfSelect() then
      if(Input_click() and self.matrice:GetId(x,y)~=0 ) then
        if self.matrice:GetTeam(x,y) == self.players:GetCurantTeam() then
          -- start select
          self.selector:Select(x,y,self.matrice:GetTeam(x,y),self.matrice:GetId(x,y))
          --self.listmoves = self.matrice:GetMoves(x,y)
          piece_moves:InitMoves(self.matrice,x,y)
        end
      end
    elseif Input_click() then      
      local sx,sy,_,_ = self.selector:Get()
      if not(sx==x and sy==y) then
        if piece_moves:IsMove(x,y) then
          self.matrice:Move(sx,sy,x,y)
          self.selector:Deselect()
          piece_moves:Reset()
          self.players:NextPlayer()
          --Ia_Stupid(self.matrice,2)
        end
      end
    end
  end
  
  if self.selector:IfSelect() then
    if Input_click2() then
      self.selector:Deselect()
      --self.listmoves = {}
      piece_moves:Reset()
    end
  end

  -- draw select
  self.selector:DrawMove(piece_moves:GetMoves())
  self.selector:DrawSelected()
end

function chess:Init()
  self.w = 8
  self.h = 8
  self.board:Init(self.w,self.h)
  self.matrice:Init(self.w,self.h)

  self.matrice:InitCell(1,1,"tour",1)
  self.matrice:InitCell(2,1,"cavalier",1)
  self.matrice:InitCell(3,1,"fou",1)
  self.matrice:InitCell(4,1,"reine",1)
  self.matrice:InitCell(5,1,"roi",1)
  self.matrice:InitCell(6,1,"fou",1)
  self.matrice:InitCell(7,1,"cavalier",1)
  self.matrice:InitCell(8,1,"tour",1)
  
  for i=1,8 do
    self.matrice:InitCell(i,2,"pion",1)
  end
  
  for i=1,8 do
    self.matrice:InitCell(i,7,"pion",2)
  end
  
  self.matrice:InitCell(1,8,"tour",2)
  self.matrice:InitCell(2,8,"cavalier",2)
  self.matrice:InitCell(3,8,"fou",2)
  self.matrice:InitCell(4,8,"reine",2)
  self.matrice:InitCell(5,8,"roi",2)
  self.matrice:InitCell(6,8,"fou",2)
  self.matrice:InitCell(7,8,"cavalier",2)
  self.matrice:InitCell(8,8,"tour",2)
  
  self.players:Add(1,"human")
  self.players:Add(2,"ia")
  
end

local function idtochar(i)
	return string.char(64+i)
end
function chess:Draw()
	local lstr_b = "" -- black text
	local lstr_w = "" -- white text
	for y=1,self.h do
		for x=1,self.w do
			if x>1 then 
				lstr_b = lstr_b.."|" 
				lstr_w = lstr_w.." "
			end
      local spiece = self.matrice:Draw(x,y)
      local spiece_b = " "
      local spiece_w = " "
      
      if self.matrice:GetTeam(x,y)==1 then
        spiece_w = spiece
      elseif self.matrice:GetTeam(x,y)==2 then
        spiece_b = spiece
      else
        if self.board:Get(x,y)==1 then
          spiece_b="="
        else
          spiece_w="="
        end
      end
      
			if self.board:Get(x,y)==1 then
				lstr_b = lstr_b.."="..spiece_b.."="
				lstr_w = lstr_w.." "..spiece_w.." "
			else
				lstr_w = lstr_w.."="..spiece_w.."="
				lstr_b = lstr_b.." "..spiece_b.." "
			end
		end
		lstr_b = lstr_b.." |"..y.."\n"
		lstr_w = lstr_w.."\n"
	end
  lstr_b = lstr_b .. "\n"
  for i=1,8 do
    lstr_b = lstr_b .. "----"
  end
  lstr_b = lstr_b .. "\n"
	for i=1,self.w do
		lstr_b = lstr_b .." "..idtochar(i) .. "  "
	end
	lstr_b = lstr_b.."\n"
  self:_drawCursor()
	love.graphics.setColor(1,1,1)
	love.graphics.print(lstr_b,16,16)
	love.graphics.setColor(0.5,0.5,0.5,1)
	love.graphics.print(lstr_w,16,16)

  print(self.players.curant)
  
end

return chess