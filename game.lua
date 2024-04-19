Game = {}

wf = require "libs/windfield"
sti = require "libs/sti"
anim8 = require "libs/anim8"

Map = require("map")
Player = require("player")
Pigs = require("Ennemis/Pigs")
Camera = require("camera")
debugging = require("debugging")
Signs = require("Signs/signs")

function Game:load()
    Map:load()
    Player:load()
    debugging:load()
end

function Game:update(dt)
    WindowW, WindowH = love.graphics.getDimensions()
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
    Map:draw()
    Pigs.drawAll()
    if debugging.isActif then
        world:draw()
    end
    Player:draw()
    Signs.drawAll()
    Camera:unset()
    print(Camera.locked)
    love.graphics.print(Camera.x .."  " .. Camera.y .. "  ")
    love.graphics.rectangle('fill', WindowW-300 , WindowH-10, Player.health*10, 10)
   
end

function Game:keypressed(key)
    Player:Jump(key)
    debugging:Switch(key)
end

function Game:touchpressed( id, x, y, dx, dy, pressure )
    Player:touchpressed(id, x, y, dx, dy, pressure)
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
