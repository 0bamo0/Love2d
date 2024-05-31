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
Background = require('background')

function Game:load()
    Background:load()
    Controls:load()
    Map:load()
    Player:load()
    debugging:load()
end

function Game:update(dt)
    Controls:update(dt)
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
    Background:draw()
    Map:draw()
    Pigs.drawAll()
    if debugging.isActif then
        world:draw()
    end
    Player:draw()
    Signs.drawAll()
    Camera:unset()
    if Sys_type == "Android" then
        Controls:draw()
    end
    love.graphics.rectangle('fill', WindowW-110 , 10 , Player.health*10, 10)
end

function Game:SaveGame()
    local gameData = {
        Player = {
            health = Player.health,
            x = Player.x,
            y = Player.y
        },
        Map = {
            level = Map.currentLevel
        }
    }
    local serializedData = Json.encode(gameData)
    -- Step 2: Write the serialized data to a file
    local fileName = "savegame.json"
    love.filesystem.write(fileName, serializedData)
end

function Game:LoadGame()
    local fileName = "savegame.json"
    local data = love.filesystem.read(fileName)
    if data then
        local loaded = Json.decode(data)
        local x = loaded.Player.x
        local y = loaded.Player.y
        Map.currentLevel = loaded.Map.level
        Map:clean()
        Map:init()
        Player.collider.body:setPosition(x, y)
        Player.collider:applyLinearImpulse(0, 10000000)
        Player.Respawning = true
    end
end

function Game:keypressed(key)
    if key == "f8" then
        self:SaveGame()
    end

    if key == "f9" then
        self:LoadGame()
    end
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
