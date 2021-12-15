local Pigs = {img = love.graphics.newImage('assets/pig.png')}
Pigs.__index = Pigs
local ActivePigs = {}

function Pigs.new(x,y,width,height,speed)
  local instance = setmetatable({}, Pigs)
  instance.x = x
  instance.y = y
  instance.dmg = 200
  if width > 16 or height > 16 then
  instance.width = 16
  instance.height = 16
  else
  instance.width = width
  instance.height = height
  end
  instance.speed = speed
  instance.stat = 'idle'
  instance.attackCooldown = 0.6
  instance.direction = 1
  instance.health = 5
  instance.collider = world:newBSGRectangleCollider(x,y,instance.width ,instance.height,15)
  instance.collider:setType('dynamic')
  instance.collider:setFixedRotation(true)
  instance.collider:setCollisionClass('Pigs')
  instance.sheet = love.graphics.newImage('assets/pig.png')
  instance.dust = love.graphics.newImage('assets/dust.png')
  instance.grid = anim8.newGrid( 33, 28, instance.sheet:getWidth(), instance.sheet:getHeight())
  instance.particles = {}
  instance.particles.dust = love.graphics.newParticleSystem(instance.dust, 100)
  instance.particles.dust:setEmissionRate(80)
  instance.particles.dust:setParticleLifetime(1,1)
  instance.particles.dust:setColors(1,1,1,1)
  instance.animation = {}
  instance.animation.idle = anim8.newAnimation( instance.grid('1-6' , 1), 0.1)
  instance.animation.walk = anim8.newAnimation( instance.grid('7-12' , 1), 0.1)
  instance.animation.attack = anim8.newAnimation( instance.grid('13-17' , 1), 0.1)
  instance.animation.hurt = anim8.newAnimation( instance.grid('18-19' , 1), 0.1)
  instance.animation.current = instance.animation.idle
  table.insert(ActivePigs, instance)
end

function Pigs:update(dt)
  self.xVel , self.yVel = self.collider:getLinearVelocity()
  self:setDirection(dt)
  self:setStat(dt)
  self:AI(dt)
  self:Timers(dt)
  self:Animate(dt)
end

function Pigs:Timers(dt)
  if self.isAttacking then
    self.stat = 'attack'
    self.attackCooldown = self.attackCooldown - dt
  end
  if self.attackCooldown < 0 then
    self.isAttacking = false
    self.attackCooldown = 0.6
  end
end

function Pigs:setDirection(dt)
  if self.xVel > 0 then self.direction = 1 elseif self.xVel < 0 then self.direction = -1 else self.direction = 1 end
end

function Pigs:Animate(dt)
  self.animation.current = self.animation[self.stat]
  self.animation.current:update(dt)
  if self.stat == 'walk' then
    self.particles.dust:setLinearAcceleration(0, 0, -self.direction*80,0)
    self.particles.dust:update(dt)
  end
end

function Pigs:setStat(dt)
  if not self.isAttacking then
  if self.xVel ~= 0 then self.stat = 'walk'
  else self.stat = 'idle' end
  end
end

function Pigs:AI(dt)
  self.x , self.y = self.collider:getPosition()
  if self.collider:enter('Player') or self.collider:stay('Player') then
    local query = world:queryRectangleArea(self.x-25 , self.y-self.height/2 , 50 ,self.height , {"Player"})
    for i,collider in ipairs(query) do
      local x,y = collider:getPosition()
      if self.x - x > 0 then self.direction = -1 elseif self.x - x < 0 then self.direction = 1 end
      self.isAttacking = true
  end
  end
  if self:checkNoGround() or self:checkWalls() then
    self.direction = -self.direction
  end
  self.collider:setLinearVelocity(self.direction*self.speed*dt*80 , self.yVel*dt*80)
end

function Pigs:checkNoGround(dt)
    local query = world:queryRectangleArea(self.x+self.direction*5,self.y+self.height/2 , 2 , 2 , {'Ground','Platforms'})
    if #query == 0 then
    return true end
end

function Pigs:checkWalls(dt)
  if self.collider:enter('Walls') then return true end
end


function Pigs:draw()
  local x,y = self.collider:getPosition()
  love.graphics.draw(self.particles.dust, x, y , 0 , 0.3 , 0.3 , self.direction*19 ,-23)
  self.animation.current:draw(self.sheet,x,y,0 , -self.direction , 1 , 19,19 )
end

function Pigs.removeAll()
  for i,instance in ipairs(ActivePigs) do
    instance.collider:destroy()
  end
  ActivePigs = {}
end

function Pigs.updateAll(dt)
   for i,instance in ipairs(ActivePigs) do
      instance:update(dt)
   end
end

function Pigs.drawAll()
   for i,instance in ipairs(ActivePigs) do
      instance:draw()
   end
end

return Pigs
