Game = {}

wf = require "libs/windfield"
sti = require "libs/sti"
camera = require "libs/camera"
anim8 = require "libs/anim8"

local Map = require("map")
local Player = require("player")
local Pigs = require("Ennemis/Pigs")
local cam = require("camera")
local debugging = require("debugging")
local Signs = require("Signs/signs")

function Game:load()
    Map:load()
    Player:load()
    cam:Load()
    debugging:load()
end

function Game:update(dt)
    Signs.updateAll(dt)
    Player:update(dt)
    Pigs.updateAll(dt)
    cam:update(dt)
    world:update(dt)
    debugging:update(dt)
    Map:update(dt)
end

function Game:draw()
    love.graphics.draw(bg, 0, 0, 0, 2, 2)
    cam:attach()
    Map:draw()
    Pigs.drawAll()
    Signs.drawAll()
    if debugging.isActif then
        world:draw()
    end
    Player:draw()
    cam:detach()
end

function Game:keypressed(key)
    Player:Jump(key)
    cam:LockToPlayer(key)
    debugging:Switch(key)
end

function Game:keyreleased(key)
    Player:Friction(key)
end

function Game:mousepressed(x, y, b)
    Player:Attack(b)
end

function Game:mousereleased(x, y, button)
end

function Game:wheelmoved(x, y)
end

return Game
