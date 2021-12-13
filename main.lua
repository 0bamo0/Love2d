love.graphics.setDefaultFilter("nearest", "nearest")
wf = require "libs/windfield"
sti = require "libs/sti"
camera = require "libs/camera"
anim8 = require "libs/anim8"


local Menu = require('menu')
local Map = require("map")
local Player = require("player")
local timer = require("libs/timer")
local Pigs = require("Ennemis/Pigs")
local cam = require("camera")
local debugging = require("debugging")
local shaders = require('shaders')


function love.load()
    Menu:load()
    shaders:load()
    Map:load()
    Player:load()
    cam:Load()
    debugging:load()
end

function love.update(dt)
  shaders:update(dt)
  if Menu.isActif then
  Menu:update(dt)
  end
  if not Menu.isActif then
    Pigs.updateAll(dt)
    Player:update(dt)
    cam:update(dt)
    world:update(dt)
    debugging:update(dt)
    Map:update(dt)
  end
end

function love.draw()
  if Menu.isActif then
    Menu:draw()
  end
  if not Menu.isActif then
    love.graphics.draw(bg, 0, 0, 0, 2, 2)
    cam:attach()
    Map:draw()
    Pigs.drawAll()
    if debugging.isActif then
        world:draw()
    end
    Player:draw()
    cam:detach()
  end
  love.graphics.print(love.timer.getFPS() , 10 , 10 )
end

function love.keypressed(key)
  if not Menu.isActif then
    Player:Jump(key)
    cam:LockToPlayer(key)
    debugging:Switch(key)
end
  Exit(key)
end

function love.keyreleased(key)
  if not Menu.isActif then
    Player:Friction(key)
  end
end

function love.mousepressed(x, y, k)
  if not Menu.isActif then
    Player:Attck(k)
  end
  if Menu.isActif then
  Menu:buttonClicked(x,y,k)
end
end

function love.mousereleased(x, y, button)
end

function love.wheelmoved(x, y)
end

function Exit(key)
    if key == "escape" and Menu.isActif then
        love.event.quit()
    end
    if key == "escape" and not Menu.isActif then
        Menu.isActif = true
    end
end
