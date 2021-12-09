local Pigs = {img = love.graphics.newImage('assets/pig.png')}
Pigs.__index = Pigs
local ActivePigs = {}

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
    table.insert(ActivePigs, instance)
end

function Pigs.LoadAssets(self)
  self.sheet = love.graphics.newImage('assets/pig.png')
  self.grid = anim8.newGrid( 34, 28, self.sheet:getWidth(), self.sheet:getHeight())
  self.setAnimations(Pigs)
end

function Pigs.setAnimations(self)
  self.animation = {}
  self.animation.walk = anim8.newAnimation( self.grid('1-6' , 1), 0.1)
  self.animation.idle = anim8.newAnimation( self.grid('1-1' , 1), 0.1)
end

function Pigs:update(dt)
  self.xVel , self.yVel = self.collider:getLinearVelocity()
  self:AI(dt)
  self:setDirection(dt)
  self:setStat(dt)
  self:Animate(dt)
  self:sync(dt)
  self:ForceMove(dt)
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
  if self.xVel > 0 then self.direction = 1 elseif self.xVel < 0 then self.direction = -1 end
end

function Pigs:AI(dt)
  if self:checkNoGround(dt) or self:checkWalls(dt) then
    self.direction = -self.direction
  end
  self.collider:setLinearVelocity(self.direction*self.speed , self.yVel)
end

function Pigs:checkNoGround(dt)
    local query = world:queryRectangleArea(self.x+self.direction*self.width/2+self.direction,self.y+self.height/2 , 1 , 1 , {'Ground','Platforms'})
    if #query == 0 then
    return true end

end

function Pigs:checkWalls(dt)
  local query = world:queryRectangleArea(self.x-self.width/2-2,self.y-self.height/2 , 2 , self.height , {'Walls'})
  local query = world:queryRectangleArea(self.x+self.width/2,self.y-self.height/2 , 2 , self.height , {'Walls'})
  if #query > 0 then
  return true end
end

function Pigs:draw()
  self.animation.current:draw(self.sheet,self.x,self.y,0 , -self.direction , 1 , self.width , self.height+3)
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

function Pigs:ForceMove(dt)
  if isDebug then
    if love.keyboard.isDown('j') then
      self.collider:setLinearVelocity(-100 , self.yVel)
    end
    if love.keyboard.isDown('l') then
      self.collider:setLinearVelocity(100 , self.yVel)
    end
  end
end

return Pigs
