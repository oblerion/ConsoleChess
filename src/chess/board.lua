---@class Board
local board = {
	---@private
	w=0,
	---@private
	h=0,
	---@private
	---@type integer[][]
	board = {}
}
---@param w integer
---@param h integer
function board:Init(w,h)
	local lstr= 0
  	self.w = w
  	self.h = h
  	self.board={}
	for y=1,self.h do
    	self.board[y] = {}
		if lstr == 0 then
			self.board[y][1] = 1
			lstr = 1
		else
			self.board[y][1] = 0
			lstr = 0
		end 
		for x=1,self.w do
			if lstr == 0 then
				self.board[y][x] = 1
				lstr = 1
			else
				self.board[y][x] = 0
				lstr = 0
			end 
		end
	end
end
---@param x integer
---@param y integer
---@return integer
function board:Get(x,y)
  return self.board[y][x]
end
---@param x integer
---@param y integer
---@param id integer
function board:Set(x,y,id)
  self.board[y][x]=id
end

return board