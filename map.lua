local Map = {}
local Player = require "player"
local Pigs = require "Ennemis/Pigs"
local Signs = require("Signs/signs")
function Map:load()
    world = wf.newWorld(0, 2000, false)
    world:setQueryDebugDrawing(true)
    self.currentLevel = 1
    world:addCollisionClass("Ground")
    world:addCollisionClass("Platforms")
    world:addCollisionClass("Walls")
    world:addCollisionClass("Pigs")
    world:addCollisionClass("Signs", {ignores = {"Pigs"}})
    world:addCollisionClass("Player", {ignores = {"Pigs", "Signs"}})
    world:addCollisionClass("Next", {ignores = {"Pigs", "Player"}})
    world:addCollisionClass("AttackCollider", {ignores = {"Player", "Pigs", "Ground", "Platforms", "Walls", "Signs"}})
    world:addCollisionClass("PigsAttack", {ignores = {"Player", "Pigs", "Ground", "Platforms", "Walls", "Signs"}})
    world:addCollisionClass("Death")
    self:init()
end

function Map:init()
    self.level = sti("maps/" .. self.currentLevel .. ".lua")
    self.level.colliders = {}
    self.groundLayer = self.level.layers.Ground
    self.platformsLayer = self.level.layers.Platforms
    self.entityLayer = self.level.layers.Entity
    self.wallsLayer = self.level.layers.Walls
    self.lvlControlLayer = self.level.layers.LevelControl

    self:LayerBuild(self.groundLayer.objects, "Ground", "static")
    self:LayerBuild(self.platformsLayer.objects, "Platforms", "static")
    self:LayerBuild(self.wallsLayer.objects, "Walls", "static")
    for i, obj in ipairs(self.lvlControlLayer.objects) do
        if obj.type == "Next" then
            local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            collider:setCollisionClass("Next")
            collider:setType("static")
            table.insert(self.level.colliders, collider)
        elseif obj.type == "Spawn" then
            Player.startX = obj.x
            Player.startY = obj.y
        elseif obj.type == "Death" then
          local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
          collider:setCollisionClass("Death")
          collider:setType("static")
          table.insert(self.level.colliders, collider)
        end
    end
    self:spawnEntities()
end

function Map:getMaxYCoord()
    local storedY = 0  
    for _,collider in ipairs(self.lvlControlLayer.objects) do
        if collider.y > storedY then
            storedY = collider.y
        else return end
    end

return storedY end

function Map:LayerBuild(layer, class, type)
    for i, obj in ipairs(layer) do
        local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
        collider:setCollisionClass(class)
        collider:setType(type)
        table.insert(self.level.colliders, collider)
    end
end

function OneWayPlatforms(collider_1, collider_2, contact)
    if collider_1.collision_class == "Player" and collider_2.collision_class == "Platforms" then
        local px, py = collider_1:getPosition()
        local pw, ph = 37, 37
        local tx, ty = collider_2:getPosition()
        local tw, th = 100, 20
        if py> ty then
            contact:setEnabled(false)
        end
    end
end

function Map:update(dt)
    if Player.collider:enter("Next") then
        self:next(dt)
    end
end

function Map:next(dt)
    self:clean()
    local n = love.filesystem.getDirectoryItems("maps")
    if self.currentLevel == #n - 1 then
        self.currentLevel = self.currentLevel
    else
        self.currentLevel = self.currentLevel + 1
    end
    self:init()
    Player:resetPosition()
end

function Map:clean()
    for i, layers in ipairs(self) do
        layers = {}
    end
    for i, collider in ipairs(self.level.colliders) do
        collider:destroy()
    end
    Pigs.removeAll()
    Signs.removeAll()
end

function Map:spawnEntities()
    for i, entity in ipairs(self.entityLayer.objects) do
        if entity.type == "pig" then
            for i = 1, entity.properties.spawnNumber do
                if entity.properties.spawnNumber > 1 then
                    local sx = math.random(entity.x, entity.x + entity.width)
                    local sy = math.random(entity.y, entity.y + entity.height)
                    Pigs.new(sx, sy, entity.width, entity.height, entity.properties.speed,entity.properties.health)
                else
                    Pigs.new(entity.x, entity.y, entity.width, entity.height, entity.properties.speed,entity.properties.health)
                end
            end
        end
        if entity.type == "sign" then
            Signs.new(entity.x, entity.y, entity.properties.id)
        end
    end
end

function Map:draw()
    local groundlayer = self.level.layers["GroundDraw"]
    if groundlayer then
    self.level:drawLayer(groundlayer)
    end
    local objectsLayer = self.level.layers["ObjectsDraw"]
    if objectsLayer then
        self.level:drawLayer(objectsLayer)
    end
end

return Map
