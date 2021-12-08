isDebug = true
love.graphics.setDefaultFilter("nearest", "nearest")
local Map = require'map'
local Player = require'player'
local timer = require'libs/timer'
local Pigs = require'Ennemis/Pigs'
function love.load()
  Effect = true

  wf = require'libs/windfield'
  sti = require'libs/sti'
  camera = require'libs/camera'
  anim8 = require "libs/anim8"
  require'camera'
  Map:load()
  Player:load()
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
      if Player.grounded then love.graphics.print('On Ground' , 0 , 10)
      else love.graphics.print('Flying', 0 , 10) end
    end
end

function debug(key)
  if key == 'u' and isDebug then
    isDebug = false
  elseif key == 'u' and not isDebug then
    isDebug = true
  end
end

function love.keypressed(key)
  Player:Jump(key)
  debug(key)
end
function love.keyreleased(key)
  Player:Friction(key)
end

function love.mousepressed(x, y, button)
end
function love.mousereleased(x, y, button)
  Player:AttackTimer(button)
end
