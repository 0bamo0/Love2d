Player = {}
function Player:load()
    self:LoadAssets()
  self.x = 0
  self.y = -1000
  self.startX = self.x
  self.startY = self.y
  self.direction = "right"
  self.state = "idle"
  self.speed = 200
  self.width = 69
  self.height = 44
  self.jumpForce = 2000
  self.collider = world:newBSGRectangleCollider(self.x , self.y , self.width , self.height,0)
  self.collider:setPreSolve(CallbackFunction)
  self.collider:setType('dynamic')
  self.collider:setFixedRotation(true)
  self.grounded = false
end

function Player:update(dt)
  self.xVel , self.yVel = self.collider:getLinearVelocity()
  self:Collisions(dt)
  self:setDirection(dt)
  self:Move(dt)
  self:setStat(dt)
self:Friction(key)
  self:Animate(dt)
end

function Player:draw()
  local scaleX = 1
  if self.direction == 'left' then
    scaleX = -1
  end
  self.animation.current:draw(self.sheet , self.x , self.y , 0 , scaleX*1.2 ,1.2, self.width/2-6 ,self.height/2)
end

function Player:Move(key)
  if love.keyboard.isDown('right','d') then
    self.collider:setLinearVelocity(self.speed , self.yVel)
  elseif
    love.keyboard.isDown('left','q') then
    self.collider:setLinearVelocity(-1 *self.speed , self.yVel)
  end
  self.x , self.y = self.collider:getPosition()

end

function Player:Friction(key)
    self.xVel , self.yVel = self.collider:getLinearVelocity()
  if (key == 'right' or key == 'q' or key == 'left' or key == 'd') then
    self.collider:setLinearVelocity(0 , self.yVel)
  end
end

function Player:LoadAssets()
  if Effects then
    self.sheet = love.graphics.newImage('assets/player/playerskin1effect.png')
  else
    self.sheet = love.graphics.newImage('assets/player/playerskin1noeffect.png')
  end
  self.grid = anim8.newGrid( 69, 44, self.sheet:getWidth(), self.sheet:getHeight() , 0 , 0 ,0)
  self.animation = {}
  self.animation.idle = anim8.newAnimation( self.grid('1-6',1), 0.1)
  self.animation.run = anim8.newAnimation( self.grid('1-6',2,'1-2',3), 0.1)
  self.animation.combo1 = anim8.newAnimation( self.grid('3-6',3,'1-3',4), 0.1)
  self.animation.combo2 = anim8.newAnimation( self.grid('4-6',4,'1-2',5), 0.1)
  self.animation.death = anim8.newAnimation( self.grid('3-6',5,'1-6',6 , '1-1', 7), 0.1)
  self.animation.hurt = anim8.newAnimation( self.grid('2-5',7), 0.1)
  self.animation.jump = anim8.newAnimation( self.grid('6-6',7 , '1-5' , 8), 0.1)
  self.animation.fall = anim8.newAnimation( self.grid('6-6',8 , '1-1',9), 0.1)
  self.animation.fullJump = anim8.newAnimation( self.grid('6-6',7 , '1-6',8 , '1-1' , 9), 0.1)
end

function  Player:Animate(dt)
  self.animation.current = self.animation[self.state]
  self.animation.current:update(dt)
end

function Player:setStat(dt)
  if not self.grounded then
      self.state = 'jump'
  end
  if self.yVel > 0 and not self.grounded then
    self.state = 'fall'
  end
  if self.grounded then
    if (self.xVel < 1 and self.xVel > -1 ) then self.state = 'idle' else self.state = 'run' end
  end
end

function Player:setDirection()
   if self.xVel < -1 then
      self.direction = "left"
   elseif self.xVel > 1 then
      self.direction = "right"
   end
end

function Player:Collisions()
  if self.collider:enter('ground') then
    self.grounded = true
  end
  if self.collider:exit('ground') then
    self.grounded = false
  end
end

function Player:Jump(key)
  if key == 'space' then
    if self.grounded then
      self.collider:applyLinearImpulse(self.xVel , -self.jumpForce)
    end
  end
end

function CallbackFunction(collider_1,collider_2,contact)
end
return Player
