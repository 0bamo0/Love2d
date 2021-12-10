local Map = {}
local Player = require'player'
local Pigs = require'Ennemis/Pigs'
function Map:load()
  world = wf.newWorld(0 , 2000 , true)
  world:setQueryDebugDrawing(true)
  self.currentLevel = 1
  world:addCollisionClass('Ground')
  world:addCollisionClass('Platforms')
  world:addCollisionClass('Ennemy')
  world:addCollisionClass('Walls')
    world:addCollisionClass('Player' , {ignores = {'Ennemy'}})

  self:init()
end

function Map:update(dt)
end

function Map:init()
  self.level = sti('maps/'..self.currentLevel..'.lua')
  self.groundLayer = self.level.layers.ground
  self.platformsLayer = self.level.layers.Platforms
  self.entityLayer = self.level.layers.entity
  self.wallsLayer = self.level.layers.Walls
  for i,v in ipairs(self.groundLayer.objects) do
    local collider = world:newRectangleCollider(v.x , v.y , v.width , v.height)
    collider:setCollisionClass('Ground')
    collider:setType('static')
  end
  for i,v in ipairs(self.platformsLayer.objects) do
    local collider = world:newRectangleCollider(v.x , v.y , v.width , v.height)
    collider:setCollisionClass('Platforms')
    collider:setType('static')
    platy = v.height
  end
  for i,v in ipairs(self.wallsLayer.objects) do
    local collider = world:newRectangleCollider(v.x , v.y , v.width , v.height)
    collider:setCollisionClass('Walls')
    collider:setType('static')
  end
  self:spawnEntities()
end

function Map:spawnEntities()
	for i,v in ipairs(self.entityLayer.objects) do
		if v.type == "pig" then
			Pigs.new(v.x, v.y ,v.width , v.height,v.properties.speed )
		end
    if v.type == "pigSpawnArea" then
      for i =1 , v.properties.spawnNumber do
			     Pigs.newArea(math.random(v.x , v.x+v.width),math.random(v.y , v.y+v.height),v.width , v.height,v.properties.speed )
      end
		end
	end
end

function Map:draw()
  self.level:drawLayer(self.level.layers['background'])
  self.level:drawLayer(self.level.layers['arbres'])
end
return Map
