local Pigs = {img = love.graphics.newImage('assets/pig.png')}
Pigs.__index = Pigs
local ActivePigs = {}
local Player = require('player')

function Pigs.new(x,y,width,height,speed)
  local instance = setmetatable({}, Pigs)
  instance.x = x
  instance.y = y
  instance.width = width
  instance.height = height
  instance.speed = speed
  instance.stat = 'idle'
  instance.direction = 1
  instance.speed = speed
  instance.collider = world:newRectangleCollider(x,y,width ,height)
  instance.collider:setType('dynamic')
  instance.collider:setFixedRotation(true)
  instance.collider:setCollisionClass('Ennemy')
  instance.sheet = love.graphics.newImage('assets/pig.png')
  instance.grid = anim8.newGrid( 34, 28, instance.sheet:getWidth(), instance.sheet:getHeight())
  instance.animation = {}
  instance.animation.walk = anim8.newAnimation( instance.grid('1-6' , 1), 0.1)
  instance.animation.idle = anim8.newAnimation( instance.grid('1-1' , 1), 0.1)
  table.insert(ActivePigs, instance)
end
function Pigs.newArea(x,y,width,height,speed)
  local instance = setmetatable({}, Pigs)
  instance.x = x
  instance.y = y
  instance.width = 19
  instance.height = 15
  instance.speed = speed
  instance.stat = 'idle'
  instance.direction = 1
  instance.speed = speed
  instance.collider = world:newRectangleCollider(x,y,19 ,15)
  instance.collider:setType('dynamic')
  instance.collider:setFixedRotation(true)
  instance.collider:setCollisionClass('Ennemy')
  instance.sheet = love.graphics.newImage('assets/pig.png')
  instance.grid = anim8.newGrid( 34, 28, instance.sheet:getWidth(), instance.sheet:getHeight())
  instance.animation = {}
  instance.animation.walk = anim8.newAnimation( instance.grid('1-6' , 1), 0.1)
  instance.animation.idle = anim8.newAnimation( instance.grid('1-1' , 1), 0.1)
  table.insert(ActivePigs, instance)
end

function Pigs:update(dt)
  self.xVel , self.yVel = self.collider:getLinearVelocity()
  self:setDirection(dt)
  self:setStat(dt)
  self:AI(dt)
  self:Animate(dt)
  self:sync(dt)
  self.chekcollision()
  self:checkRemove(dt)
end

function Pigs:Animate(dt)
  self.animation.current = self.animation[self.stat]
  self.animation.current:update(dt)
end

function Pigs:sync(dt)
self.x , self.y = self.collider:getPosition()
end

function Pigs:setStat(dt)
  if self.xVel ~= 0 then self.stat = 'walk'
  else self.stat = 'idle' end
end

function Pigs:setDirection(dt)
  if self.xVel > 0 then self.direction = 1 elseif self.xVel < 0 then self.direction = -1 else self.direction = 1 end
end

function Pigs:AI(dt)
  if self:checkPlayer(dt) then
    self:walkToPlayer(dt)
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
  if self.x - Player.x < 0 then
    self.direction = 1
  end
  if self.x - Player.x > 0 then
    self.direction = -1
  end
end

function Pigs:checkRemove(dt)
  if self.toBeRemoved then
    self:remove()
  end
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
  self.animation.current:draw(self.sheet,self.x,self.y,0 , -self.direction , 1 , self.width , self.height+3)
end

function Pigs:checkForAttacks()
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
   if instance.collider:enter('Player') then
     instance.toBeRemoved = true
   end
 end
end

return Pigs
