Game = {}

wf = require "libs/windfield"
sti = require "libs/sti"
anim8 = require "libs/anim8"
Json = require('libs/json')


Map = require("map")
Player = require("player")
Pigs = require("Ennemis/Pigs")
Camera = require("camera")
debugging = require("debugging")
Signs = require("Signs/signs")
Controls = require('controls')
Background = require('background')

Game.saveSlotCount = 3
Game.currentSaveSlot = 1
Game.lastSaveMessage = ""
Game.lastSaveMessageTimer = 0


function Game:load()
    Background:load()
    Controls:load()
    Map:load()
    Player:load()
    debugging:load()
end

function Game:update(dt)
    if self.lastSaveMessageTimer > 0 then
        self.lastSaveMessageTimer = self.lastSaveMessageTimer - dt
    end
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
    Background:draw()
    Camera:set()
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
    if self.lastSaveMessageTimer > 0 then
        love.graphics.print(self.lastSaveMessage, 20, 20)
    end
end

function Game:showSaveMessage(message)
    self.lastSaveMessage = message
    self.lastSaveMessageTimer = 2
end

function Game:normalizeSlot(slot)
    slot = tonumber(slot) or self.currentSaveSlot or 1
    slot = math.floor(slot)
    if slot < 1 then
        return 1
    end
    if slot > self.saveSlotCount then
        return self.saveSlotCount
    end
    return slot
end

function Game:getSaveFileName(slot)
    slot = self:normalizeSlot(slot)
    return "savegame_slot_" .. slot .. ".json"
end

function Game:getLegacySaveFileName()
    return "savegame.json"
end

function Game:hasSave(slot)
    slot = self:normalizeSlot(slot)
    if love.filesystem.getInfo(self:getSaveFileName(slot), "file") then
        return true
    end
    return slot == 1 and love.filesystem.getInfo(self:getLegacySaveFileName(), "file") ~= nil
end

function Game:readSave(slot)
    slot = self:normalizeSlot(slot)
    local fileName = self:getSaveFileName(slot)
    local data = love.filesystem.read(fileName)
    if not data and slot == 1 then
        data = love.filesystem.read(self:getLegacySaveFileName())
    end
    if not data then
        return nil
    end

    local ok, loaded = pcall(Json.decode, data)
    if ok then
        return loaded
    end
end

function Game:deleteSave(slot)
    slot = self:normalizeSlot(slot)
    love.filesystem.remove(self:getSaveFileName(slot))
    if slot == 1 then
        love.filesystem.remove(self:getLegacySaveFileName())
    end
end

function Game:getSaveSummary(slot)
    local loaded = self:readSave(slot)
    if not loaded or not loaded.Player or not loaded.Map then
        return "Slot " .. self:normalizeSlot(slot) .. " - Empty"
    end

    return "Slot " .. self:normalizeSlot(slot) ..
        " - Level " .. tostring(loaded.Map.level or "?") ..
        " HP " .. tostring(loaded.Player.health or "?")
end

function Game:newGame(slot)
    self.currentSaveSlot = self:normalizeSlot(slot)
    Map.currentLevel = 1
        Map:clean()
        Map:init()
        Player.health = 10
        Player.collider.body:setPosition(Player.startX, Player.startY)
        Player.x = Player.startX
        Player.y = Player.startY
        Player.collider:applyLinearImpulse(0, 10000000)
        Player.Respawning = true
end

function Game:SaveGame(slot)
    slot = self:normalizeSlot(slot)
    self.currentSaveSlot = slot
    local gameData = {
        version = 2,
        slot = slot,
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
    local fileName = self:getSaveFileName(slot)
    love.filesystem.write(fileName, serializedData)
    self:showSaveMessage("Saved slot " .. slot)
    return true
end

function Game:LoadGame(slot)
    slot = self:normalizeSlot(slot)
    local loaded = self:readSave(slot)
    if not loaded or not loaded.Player or not loaded.Map then
        self:showSaveMessage("Slot " .. slot .. " is empty")
        return false
    end

    local x = loaded.Player.x or Player.startX
    local y = loaded.Player.y or Player.startY
    self.currentSaveSlot = slot
    Map.currentLevel = loaded.Map.level or 1
    Map:clean()
    Map:init()
    Player.health = loaded.Player.health or Player.health
    Player.collider.body:setPosition(x, y)
    Player.x = x
    Player.y = y
    Player.collider:applyLinearImpulse(0, 10000000)
    Player.Respawning = true
    self:showSaveMessage("Loaded slot " .. slot)
    return true
end

function Game:keypressed(key)
    if key == "f5" then
        self:SaveGame(1)
    elseif key == "f6" then
        self:SaveGame(2)
    elseif key == "f7" then
        self:SaveGame(3)
    end

    if key == "f9" then
        self:LoadGame(1)
    elseif key == "f10" then
        self:LoadGame(2)
    elseif key == "f11" then
        self:LoadGame(3)
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
