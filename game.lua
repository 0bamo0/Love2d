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
Controls = require('controls')

function Game:load()
    Controls:load()
    Map:load()
    Player:load()
    debugging:load()
end

function Game:update(dt)
    Signs.updateAll(dt)
    Player:update(dt)
    Pigs.updateAll(dt)
    world:update(dt)
    debugging:update(dt)
    Map:update(dt)
    Camera:update(dt)
    
end

function Game:draw()
    love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)
    Camera:set()
    Map:draw()
    Pigs.drawAll()
    if debugging.isActif then
        world:draw()
    end
    Player:draw()
    Signs.drawAll()
    Camera:unset()
    Controls:draw()
    love.graphics.rectangle('fill', WindowW-110 , 10 , Player.health*10, 10)
end

function Game:keypressed(key)
    Player:Jump(key)
    debugging:Switch(key)
end

function Game:touchpressed( id, x, y, dx, dy, pressure )
    Player:touchpressed(id, x, y, dx, dy, pressure)

end

function Game:touchreleased(id, x, y, dx, dy, pressure)
    Player:touchreleased(id, x, y, dx, dy, pressure)
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
