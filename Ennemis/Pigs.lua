local Pigs = {img = love.graphics.newImage('assets/pig.png')}
Pigs.__index = Pigs

local ActivePigs = {}
function Pigs.new(x,y,width,height)
  local instance = setmetatable({}, Pigs)
  instance.x = x
  instance.y = y
  instance.width = width
  instance.height = height
  instance.stat = 'idle'
  instance.direction = 'left'
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

function Pigs:update(dt)
  self.xVel , self.yVel = self.collider:getLinearVelocity()
  self:setDirection(dt)
  self:setStat(dt)
  self:Animate(dt)
  self:sync(dt)
end

function Pigs:animations(args)

end

function Pigs:Animate(dt)
  self.anim = self.animation[self.stat]
  self.anim:update(dt)
end

function Pigs:sync(dt)
self.x , self.y = self.collider:getPosition()
end

function Pigs:setStat(dt)
  if self.xVel ~= 0 then self.stat = 'walk'
  else self.stat = 'idle' end
end
function Pigs:setDirection(dt)
  if self.xVel < 0 then self.direction = 'left'
  elseif self.xVel > 0 then self.direction = 'right' end
end

function Pigs:draw()
  local scale = 1
  if self.direction == 'left' then scale = 1 else scale = -1 end
  self.anim:draw(self.sheet,self.x,self.y,0 , scale , 1 , self.width , self.height+3)
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
