local Pigs = {img = love.graphics.newImage('assets/pig.png')}
Pigs.__index = Pigs
local ActivePigs = {}
local Player = require('player')

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
  instance.speed = speed
  instance.collider = world:newRectangleCollider(x,y,instance.width ,instance.height)
  instance.collider:setType('dynamic')
  instance.collider:setFixedRotation(true)
  instance.collider:setCollisionClass('Ennemy')
  instance.sheet = love.graphics.newImage('assets/pig.png')
  instance.dust = love.graphics.newImage('assets/dust.png')
  instance.grid = anim8.newGrid( 50, 50, instance.sheet:getWidth(), instance.sheet:getHeight())
  instance.particles = {}
  instance.particles.dust = love.graphics.newParticleSystem(instance.dust, 100)
  instance.particles.dust:setEmissionRate(80)
  instance.particles.dust:setParticleLifetime(1,1)
  instance.particles.dust:setColors(1, 1, 0, 1, 1, 0, 1, 1)
  instance.animation = {}
  instance.animation.walk = anim8.newAnimation( instance.grid('1-6' , 2), 0.1)
  instance.animation.idle = anim8.newAnimation( instance.grid('1-6' , 1), 0.1)
  instance.animation.attck = anim8.newAnimation( instance.grid('4-6' , 3,'1-2',4), 0.1)
  instance.animation.current = instance.animation.idle

  table.insert(ActivePigs, instance)
end

function Pigs:update(dt)
  self.xVel , self.yVel = self.collider:getLinearVelocity()
  self:setDirection(dt)
  self:AI(dt)
  self:setStat(dt)
  self:Animate(dt)
  self:sync(dt)
  self:Timers(dt)
end

function Pigs:Animate(dt)
  self.animation.current = self.animation[self.stat]
  self.animation.current:update(dt)
  if self.stat == 'walk' then
  self.particles.dust:setLinearAcceleration(0, 0, -self.direction*80,0)
  self.particles.dust:update(dt)
  end
end

function Pigs:sync(dt)
self.x , self.y = self.collider:getPosition()
end

function Pigs:setStat(dt)
  if not self.isAttcking then
  if self.xVel ~= 0 then self.stat = 'walk'
  else self.stat = 'idle' end
  end
end

function Pigs:setDirection(dt)
  if self.xVel > 0 then self.direction = 1 elseif self.xVel < 0 then self.direction = -1 else self.direction = 1 end
end

function Pigs:AI(dt)
  if self:checkPlayer(dt) then
    self:walkToPlayer(dt)
    self:attckPlayer(dt)
  end
  if (self:checkNoGround(dt) or self:checkWalls(dt)) then
    self.direction = -self.direction
  end
  self.collider:setLinearVelocity(self.direction*self.speed , self.yVel)
end

function Pigs:checkNoGround(dt)
    local query = world:queryRectangleArea(self.x+self.direction*5,self.y+self.height/2 , 2 , 2 , {'Ground','Platforms'})
    if #query == 0 then
    return true end
end

function Pigs:checkWalls(dt)
  if self.collider:enter('Walls') then return true end
end

function Pigs:checkPlayer(dt)
  local query = world:queryRectangleArea(self.x-40 , self.y-self.height/2 , 80 ,self.height, {'Player'})
  local query = world:queryRectangleArea(self.x-40-self.width/2 , self.y-self.height/2 , 80 ,self.height, {'Player'})
  if #query > 0 then return true end
end

function Pigs:walkToPlayer(dt)
  if self.x - Player.x < -30 then
    self.direction = 1
  elseif self.x - Player.x > 30 then
    self.direction = -1
  end
end

function Pigs:checkRemove(dt)
  if self.toBeRemoved then
    self:remove()
  end
end

function Pigs:attckPlayer(dt)
  if self.collider:enter('Player') then
    Player:hurt(self.dmg*self.direction,dt)
    self.isAttcking = true
    self.stat = 'attck'
  end
end

function Pigs.removeAll()
  for i,instance in ipairs(ActivePigs) do
    instance.collider:destroy()
  end
  ActivePigs = {}
end

function Pigs:remove()
  for i,instance in ipairs(ActivePigs) do
      if instance == self then
         self.collider:destroy()
         table.remove(ActivePigs, i)
      end
   end
end

function Pigs:draw()
  local x,y = self.collider:getPosition()
  love.graphics.draw(self.particles.dust, x, y , 0 , 0.3 , 0.3 , self.direction*25 ,-23)
  self.animation.current:draw(self.sheet,x,y,0 , -self.direction , 1 , 23 , 23)

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

function Pigs.chekcollision()
 for i,instance in ipairs(ActivePigs) do
   if instance.collider:enter('Attck') then
     instance.toBeRemoved = true
   end
 end
end

function Pigs:Timers(dt)
    if self.isAttcking then
        self.stat = "attck"
        self.attackCooldown = self.attackCooldown - dt
    end
    if self.attackCooldown < 0 then
      self:setStat()
      self.isAttcking = false
      self.attackCooldown = 0.5
    end
end
return Pigs
