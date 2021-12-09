love.graphics.setDefaultFilter("nearest", "nearest")
wf = require'libs/windfield'
sti = require'libs/sti'
camera = require'libs/camera'
anim8 = require "libs/anim8"


local Map = require('map')
local Player = require('player')
local timer = require('libs/timer')
local Pigs = require('Ennemis/Pigs')
local cam = require('camera')

function love.load()

  isDebug = true
  Map:load()
  Player:load()
  Pigs.LoadAssets(Pigs)
  cam:Load()
end

function love.update(dt)
  Player:update(dt)
  Pigs.updateAll(dt)
  cam:update(dt)
  Map:update(dt)
  world:update(dt)
end

function love.draw()
  cam:attach()
  Map:draw()
  Pigs.drawAll()
  Player:draw()
  if isDebug then world:draw() end
  cam:detach()

  if isDebug then
  love.graphics.print(Player.xVel)
    if Player.grounded then
      love.graphics.print('On Ground' , 0 , 10)
    else love.graphics.print('Flying', 0 , 10) end
  end
end
function love.keypressed(key)
  Player:Jump(key)
  debug(key)
  log(key)
  Exit (key)
  cam:LockToPlayer(key)
end

function debug(key)
  if key == 'u' and isDebug then
    isDebug = false
  elseif key == 'u' and not isDebug then
    isDebug = true
  end
end

function Exit(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function log(key,content)
  if key == '0' and isDebug then
  end
end

function love.keyreleased(key)
  Player:Friction(key)
end

function love.mousepressed(x, y,key)
  Player:FastAttack(key)
end

function love.mousereleased(x, y, button)
  Player:AttackTimer(button)
end

function love.wheelmoved(x, y)
  cam:Zoom(x,y)
end
