local Map = {}
local Player = require "player"
local Pigs = require "Ennemis/Pigs"

function Map:load()
bg = love.graphics.newImage('assets/background.png')
    world = wf.newWorld(0, 2000, false)
    world:setQueryDebugDrawing(false)
    self.currentLevel = 1
    world:addCollisionClass("Ground")
    world:addCollisionClass("Platforms")
    world:addCollisionClass("Ennemy")
    world:addCollisionClass("Walls")
    world:addCollisionClass("Player", {ignores = {"Ennemy"}})
    world:addCollisionClass("Next", {ignores = {"Ennemy", "Player"}})
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

    for i, obj in ipairs(self.groundLayer.objects) do
        local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
        collider:setCollisionClass("Ground")
        collider:setType("static")
        table.insert(self.level.colliders, collider)
    end
    for i, obj in ipairs(self.platformsLayer.objects) do
        local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
        collider:setCollisionClass("Platforms")
        collider:setType("static")
        table.insert(self.level.colliders, collider)
        platy = obj.height
    end
    for i, obj in ipairs(self.wallsLayer.objects) do
        local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
        collider:setCollisionClass("Walls")
        collider:setType("static")
        table.insert(self.level.colliders, collider)
    end
    for i, obj in ipairs(self.lvlControlLayer.objects) do
      if obj.type == 'Next' then
        local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
        collider:setCollisionClass("Next")
        collider:setType("static")
        table.insert(self.level.colliders, collider)
      elseif obj.type == 'Spawn' then
        Player.startX = obj.x
        Player.startY = obj.y
      end
    end
    self:spawnEntities()
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
        self.currentLevel = self.currentLevel
    end
    self:init()
    Player:resetPosition(dt)
end

function Map:clean()
    for i, layers in ipairs(self) do
        layers = {}
    end
    for i, collider in ipairs(self.level.colliders) do
        collider:destroy()
    end
    Pigs.removeAll()
end

function Map:spawnEntities()
    for i, entity in ipairs(self.entityLayer.objects) do
        if entity.type == "pig" then
            for i = 1, entity.properties.spawnNumber do
              if entity.properties.spawnNumber > 1 then
                local sx = math.random(entity.x ,entity.x+entity.width)
                local sy = math.random(entity.y ,entity.y+entity.height)
                Pigs.new(sx, sy, entity.width, entity.height, entity.properties.speed)
              else
                Pigs.new(entity.x, entity.y, entity.width, entity.height, entity.properties.speed)
              end
            end
        end
    end
end

function Map:draw()
    self.level:drawLayer(self.level.layers["GroundDraw"])
end

return Map
