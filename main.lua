love.graphics.setDefaultFilter("nearest", "nearest")
local Map = require'map'
local Player = require'player'
local timer = require'libs/timer'
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

  cam:update(dt)
  Player:update(dt)
  Map:update(dt)
  world:update(dt)

end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.setBackgroundColor(0, 1, 1 ,1)
    cam:attach()
  Map:draw()
  Player:draw()
  world:draw()
    cam:detach()
  love.graphics.setColor(0, 0, 0)
love.graphics.print(Player.xVel)
  if Player.grounded then
    love.graphics.print('On Ground' , 0 , 10)
  else
    love.graphics.print('Flying', 0 , 10)
  end
  if Player.is_hitting_wall_from_left then
  love.graphics.print('left' , 0 , 20)
  end
  if Player.is_hitting_wall_from_right then
  love.graphics.print('right' , 0 , 20)
  end
end


function love.keypressed(key)
  Player:Jump(key)
end
function love.keyreleased(key)
  Player:Friction(key)
end
