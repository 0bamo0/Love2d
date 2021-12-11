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
local debugging = require('debugging')

function love.load()
  Map:load()
  Player:load()
  cam:Load()

  debugging:load()
end

function love.update(dt)
  Map:update(dt)
  Player:update(dt)
  Pigs.updateAll(dt)
  cam:update(dt)
  world:update(dt)
end

function love.draw()
  cam:attach()
  Map:draw()
  Pigs.drawAll()
  Player:draw()
  if debugging.isActif then world:draw() end
  cam:detach()
  debugging:draw()
end
function love.keypressed(key)
  Player:Jump(key)
  debugging:Switch(key)
  Exit (key)
  cam:LockToPlayer(key)
end

function Exit(key)
  if key == 'escape' then
    love.event.quit()
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
