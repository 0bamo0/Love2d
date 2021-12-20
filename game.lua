Game = {}

wf = require "libs/windfield"
sti = require "libs/sti"
anim8 = require "libs/anim8"

local Background = require('background')
local Map = require("map")
local Player = require("player")
local Pigs = require("Ennemis/Pigs")
local Camera = require("camera")
local debugging = require("debugging")
local Signs = require("Signs/signs")

function Game:load()
    Background:load()
    Map:load()
    Player:load()
    debugging:load()
end

function Game:update(dt)
    Background:update(dt)
    Signs.updateAll(dt)
    Player:update(dt)
    Pigs.updateAll(dt)
    world:update(dt)
    debugging:update(dt)
    Map:update(dt)
    Camera:update(dt)
end

function Game:draw()
    Camera:set()
    Background:draw()
    Map:draw()
    Pigs.drawAll()
    if debugging.isActif then
        world:draw()
    end
    Player:draw()
    Signs.drawAll()
    Camera:unset()
    love.graphics.rectangle('fill', 600, 10, Player.health*10, 10)
end

function Game:keypressed(key)
    Player:Jump(key)
    Player:Dash(key)
    Camera:setMode(key)
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
    Camera:Zoom(x,y)
end

return Game
