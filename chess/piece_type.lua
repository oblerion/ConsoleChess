---@class Piece_type
local piece_type = {
  {"pion","p"},
  {"cavalier","h"},
  {"fou","f"},
  {"tour","T"},
  {"roi","K"},
  {"reine","Q"}
}
  
  -- id matrice to char to draw
---@param id integer
function piece_type:GetTag(id)
  if id<7 and id>0 then
    return self[id][1]
  end
  return ""
end
---@param tag string
---@return integer
function piece_type:GetId(tag)
  local n=1
  for n=1,6 do
    if self[n][1] == tag then
      return n
    end
  end
  return 0
end
---@param id integer
---@return string
function piece_type:Draw(id)
  if id>0 and id<7 then
    return self[id][2]
  end
  return " "
end

return piece_type