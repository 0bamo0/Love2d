love.graphics.setDefaultFilter("nearest", "nearest")
wf = require "libs/windfield"
sti = require "libs/sti"
camera = require "libs/camera"
anim8 = require "libs/anim8"

local Map = require("map")
local Player = require("player")
local timer = require("libs/timer")
local Pigs = require("Ennemis/Pigs")
local cam = require("camera")
local debugging = require("debugging")

function love.load()
  bg = love.graphics.newImage('assets/background.png')
    Map:load()
    Player:load()
    cam:Load()
    debugging:load()
end

function love.update(dt)
    Pigs.updateAll(dt)
    Player:update(dt)
    cam:update(dt)
    world:update(dt)
    debugging:update(dt)
    Map:update(dt)
end

function love.draw()
  love.graphics.draw(bg, 0 , 0 , 0 , 2)
    cam:attach()
    Map:draw()
    Pigs.drawAll()
    if debugging.isActif then
        world:draw()
    end
    Player:draw()
    cam:detach()
end

function love.keypressed(key)
    Player:Jump(key)
    debugging:Switch(key)
    Exit(key)
    cam:LockToPlayer(key)
end

function love.keyreleased(key)
    Player:Friction(key)
end

function love.mousepressed(x, y, key)
end

function love.mousereleased(x, y, button)
end

function love.wheelmoved(x, y)
end

function Exit(key)
    if key == "escape" then
        love.event.quit()
    end
end
