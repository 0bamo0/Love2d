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
  Player = require'player'
  require'camera'
  Map:load()
  Player:load()
end

function love.update(dt)
  world:update(dt)
  cam:update(dt)
  Player:update(dt)
  Map:update(dt)

end

function love.draw()
    cam:attach()
  Map:draw()
  Player:draw()
  world:draw()
    cam:detach()
love.graphics.print(Player.xVel)
end

function love.keypressed(key)
  Player:Jump(key)
end
function love.keyreleased(key)
  Player:Friction(key)
end
