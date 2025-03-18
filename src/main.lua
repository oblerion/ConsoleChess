--debug
io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end
love.graphics.setDefaultFilter("nearest")
require("state.statemanager")
require("state.title")
require("state.game")

---@class sm : StateManager
local sm = StateManager()

function love.load()
  love.graphics.setNewFont("asset/tic-80-wide-font.ttf",16)
	love.graphics.setBackgroundColor(1,1,1,1)
  sm:AddState(StateTitle())
  sm:AddState(StateGame())
end

function love.update(dt)
  sm:Update()
end


function love.draw()
  love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setColor(1,1,1,1)
  sm:Draw()
end
