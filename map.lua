local Map = {}
function Map:load()
  world = wf.newWorld(0 , 1000 , true)
  self.currentLevel = 1
  world:addCollisionClass('ground')

  self:init()
end

function Map:update(dt)
end

function Map:init()
  self.level = sti('maps/'..self.currentLevel..'.lua')
  self.groundLayer = self.level.layers.ground
  self.entityLayer = self.level.layers.entity
  for i,v in ipairs(self.groundLayer.objects) do
    local collider = world:newRectangleCollider(v.x , v.y , v.width , v.height)
    collider:setCollisionClass('ground')
    collider:setType('static')
  end

  self:spawnEntities()
end

function Map:spawnEntities()
	for i,v in ipairs(self.entityLayer.objects) do
		if v.type == "spikes" then
			Spike.new(v.x + v.width / 2, v.y + v.height / 2)
		end
	end
end

function Map:draw()
  self.level:drawLayer(self.level.layers['background'])
  self.level:drawLayer(self.level.layers['arbres'])
end

return Map
