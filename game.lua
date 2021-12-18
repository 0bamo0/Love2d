Game = {}

wf = require "libs/windfield"
sti = require "libs/sti"
camera = require "libs/camera"
anim8 = require "libs/anim8"

local Background = require('background')
local Map = require("map")
local Player = require("player")
local Pigs = require("Ennemis/Pigs")
local cam = require("camera")
local debugging = require("debugging")
local Signs = require("Signs/signs")

function Game:load()
    Background:load()
    Map:load()
    Player:load()
    cam:Load()
    debugging:load()
end

function Game:update(dt)
    Background:update(dt)
    Signs.updateAll(dt)
    Player:update(dt)
    Pigs.updateAll(dt)
    cam:update(dt)
    world:update(dt)
    debugging:update(dt)
    Map:update(dt)
end

function Game:draw()
    local imgW ,imgH= Background.static:getWidth() , Background.static:getHeight()
    local ww,wh = love.graphics.getDimensions()
    love.graphics.draw(Background.static , 0 , 0 , 0 , ww/imgW , ww/imgW)

    cam:attach()
    Background:draw()
    Map:draw()
    Pigs.drawAll()
    if debugging.isActif then
        world:draw()
    end
    Player:draw()
    Signs.drawAll()
    cam:detach()
    love.graphics.rectangle('fill', 600, 10, Player.health*10, 10)
end

function Game:keypressed(key)
    Player:Jump(key)
    Player:Dash(key)
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
