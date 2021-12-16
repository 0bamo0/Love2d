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
  instance.direction = 1
  instance.attacktimer = 0.4
  instance.attackCD = 2
  instance.health = 5
  instance.hurtTimer = 0.2
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

  instance.canAttack = true
  table.insert(ActivePigs, instance)
end

function Pigs:update(dt)
  print(self.attackCD)
  self.xVel , self.yVel = self.collider:getLinearVelocity()
  self:setDirection(dt)
  self:setStat(dt)
  self:AI(dt)
  self:Timers(dt)
  self:Animate(dt)
end

function Pigs:Timers(dt)
  if self.isAttcking then
    self.stat = 'attack'
    self.attacktimer = self.attacktimer - dt
  end
  if self.attacktimer < 0 then
    self.attackCollider:destroy()
    self.isAttcking = false
    self.attacktimer = 0.4
  end
  if not self.canAttack then
    self.attackCD = self.attackCD - dt
  end
  if self.attackCD < 0 then
    self.attackCD = 2
    self.canAttack = true
  end
  if self.ishurt then
    self.stat = 'hurt'
    self.hurtTimer = self.hurtTimer - dt
  end
  if self.hurtTimer < 0 then
    self.ishurt = false
    self.hurtTimer = 0.2
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
  if not self.ishurt then
  if not self.isAttacking then
  if self.xVel ~= 0 then self.stat = 'walk'
  else self.stat = 'idle' end
  end
  end
end

function Pigs:AI(dt)
  self.x , self.y = self.collider:getPosition()
  self:checkForPlayer(dt)
  if self:checkNoGround() or self:checkWalls() then
    self.direction = -self.direction
  end
  if self.collider:enter('AttackCollider') then
    self.ishurt = true
  end
  if self.ishurt then
    self.collider:setLinearVelocity(0 , self.yVel)
  else
    self.collider:setLinearVelocity(self.direction*self.speed , self.yVel)
  end
end
function Pigs:checkForPlayer(dt)
  local vision = world:queryRectangleArea(self.x-55 ,self.y-self.height/2 , 100 , self.height,{'Player'})
  if #vision > 0 then self:walkToPlayer(vision,dt) else return false end
end
function Pigs:walkToPlayer(vision,dt)
 for i,v in ipairs(vision) do
   local x,y = v:getPosition()
   if self.x - x < -20 then self.direction = 1 elseif self.x - x > 20 then self.direction = -1 end
   if (self.collider:enter('Player') or self.collider:stay('Player')) then
     if self.canAttack then
     self:attackPlayer()
     self.canAttack = false
   end
   end
end
end

function Pigs:attackPlayer()
  self.isAttcking = true
  if self.direction == 1 then
  self.attackCollider = world:newRectangleCollider(self.x+8,self.y-self.height/2 , 10 , self.height)
elseif self.direction == -1 then
  self.attackCollider = world:newRectangleCollider(self.x-18,self.y-self.height/2 , 10 , self.height)
end
  self.attackCollider:setType('static')
  self.attackCollider:setCollisionClass('PigsAttack')
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
