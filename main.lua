--debug
io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end
love.graphics.setDefaultFilter("nearest")
---@class chess : Chess
local chess = require("chess")

function love.load()
	love.graphics.setNewFont("asset/tic-80-wide-font.ttf",16)
	love.graphics.setBackgroundColor(1,1,1,1)
  chess:Init()
end

function love.update(dt)
  if love.keyboard.isDown("r") then
    chess:Init()
  end

end

function love.draw()
  love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setColor(0,0,0,1)
	chess:Draw()
  love.graphics.setColor(1,1,1,1)
  love.graphics.print("press r for reset",10,230)
end
