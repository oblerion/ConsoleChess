---@private
local function _getNbTouch()
  return #love.touch.getTouches()
end
---@return boolean
function Input_click()
  if _getNbTouch()==1 then
    return true
  end
  return love.mouse.isDown(1)
end
---@return boolean
function Input_click2()
  if _getNbTouch()==2 then
    return true
  end
  return love.mouse.isDown(2)
end
---@return boolean
function Input_click3()
  if _getNbTouch()==3 then
    return true
  end
  return love.mouse.isDown(3)
end

---@return integer
function Input_getX()
  if _getNbTouch() > 0 then
    local x,_ = love.touch.getPosition( love.touch.getTouches()[1])
    return x
  end
  return love.mouse.getX()
end
---@return integer
function Input_getY()
  if _getNbTouch() > 0 then
    local _,y = love.touch.getPosition( love.touch.getTouches()[1])
    return y
  end
  return love.mouse.getY()
end

