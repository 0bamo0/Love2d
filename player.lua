local Player = {}
function Player:load()
  self:LoadAssets()
  self.x = 100
  self.y = 210
  self.startX = self.x
  self.startY = self.y
  self.direction = "right"
  self.stat = "idle"
  self.speed = 200
  self.width = 18
  self.height = 33
  self.jumpForce = 1000
  self.attackRange = 1
  self.collider = world:newRectangleCollider(self.x , self.y , self.width , self.height)
  self.collider:setCollisionClass('Player')
  self.collider:setFixedRotation(true)
  self.collider:setType('dynamic')
  function Custom(collider_1, collider_2, contact)
    if collider_1.collision_class == 'Player' and collider_2.collision_class == 'Platforms' then
      local px, py = collider_1:getPosition()
      local pw, ph = 22, 34.5
      local tx, ty = collider_2:getPosition()
      local tw, th = 100, 20
      if py + self.height/2 > ty - platy/2 then
        contact:setEnabled(false)
      end
    end
    combo = 1.2
    combostat = 1
  end
  self.collider:setPreSolve(Custom)
  self.grounded = false
  self.onPlatform = false
  self.canMove = true


end

function Player:update(dt)
  self.xVel , self.yVel = self.collider:getLinearVelocity()
  self.wallsLeft = false
  self.wallsRight = false
  self:Collisions(dt)
  self:setDirection(dt)
  self:Move(dt)
  self:Friction(key)
  self:setStat(dt)
  self:Attack(dt)
  self:Animate(dt)
end

function Player:draw()
  local scaleX = 1
  if self.direction == 'left' then
    scaleX = -1
  elseif self.direction == 'right' then
    scaleX = 1
  end
  self.animation.current:draw(self.sheet , self.x , self.y , 0 , scaleX ,1, self.width+8,self.height-7)
end

function Player:Move(key)
  if love.keyboard.isDown('right','d') and not self.wallsRight and self.canMove then
    self.collider:setLinearVelocity(self.speed , self.yVel)
    self.direction = 'right'
  elseif
    love.keyboard.isDown('left','q') and not self.wallsLeft and self.canMove then
    self.collider:setLinearVelocity(-1 *self.speed , self.yVel)
    self.direction = 'left'
  end
  self.x , self.y = self.collider:getPosition()
end

function Player:Friction(key)
    self.xVel , self.yVel = self.collider:getLinearVelocity()
  if (key == 'right' or key == 'q' or key == 'left' or key == 'd') then
    self.collider:setLinearVelocity(0 , self.yVel)
    self.animation.current:gotoFrame(1)
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
  self.animation.attack = anim8.newAnimation( self.grid('3-6',3,'1-6',4 , '1-2',5), 0.04)
  self.animation.death = anim8.newAnimation( self.grid('3-6',5,'1-6',6 , '1-1', 7), 0.1)
  self.animation.hurt = anim8.newAnimation( self.grid('2-5',7), 0.1)
  self.animation.jump = anim8.newAnimation( self.grid('6-6',7 , '1-5' , 8), 0.1)
  self.animation.fall = anim8.newAnimation( self.grid('6-6',8 , '1-1',9), 0.1)
  self.animation.fullJump = anim8.newAnimation( self.grid('6-6',7 , '1-6',8 , '1-1' , 9), 0.1)
end

function  Player:Animate(dt)
  self.animation.current = self.animation[self.stat]
  self.animation.current:update(dt)
end

function Player:setStat(dt)
      if self.yVel < 0 then
        self.stat = 'jump' end
      if self.yVel > 0 then
        self.stat = 'fall' end

  if (self.grounded or self.onPlatform) then
    if self.xVel ~= 0 then
      self.stat = 'run'
    else
      self.stat = 'idle'
    end
  end
end

function Player:setDirection()
   if self.xVel < 0 then
      self.direction = "left"
   elseif self.xVel > 0 then
      self.direction = "right"
   end
end

function Player:Collisions(dt)
  local query1 = world:queryRectangleArea(self.x-self.width/2,self.y+self.height/2, self.width , 1 , {'Ground' , 'Platforms'})
  if #query1 == 1 then
    self.grounded = true
  else
    self.grounded = false
  end
  local query2Right = world:queryRectangleArea(self.x+self.width/2+1,self.y-self.height/2 , 1 , self.height , {'Ground' , 'Platforms'})
  if #query2Right == 1 then
    self.wallsRight = true
  else
    self.wallsRight = false
  end
  local query2Left = world:queryRectangleArea(self.x-self.width/2-1,self.y-self.height/2 , 1 , self.height , {'Ground' , 'Platforms'})
  if #query2Left == 1 then
    self.wallsLeft = true
  else
    self.wallsLeft = false
  end
end

function Player:Jump(key)
  if key == 'space' then
    if (self.grounded or self.onPlatform) then
      self.collider:applyLinearImpulse(self.xVel , -self.jumpForce)
    end
  end
end

function Player:Attack(dt)
  if love.mouse.isDown(1) then
    self.stat = 'attack'
    local dir = 0
    if self.direction == 'left' then
      dir = -1
    else
      dir = 1
    end
    local query = world:queryRectangleArea(self.x+self.width*dir-10 , self.y-5 , 30 , 10 ,{'Ennemy'} )
    for i , v in ipairs(query) do
      v:applyLinearImpulse(100*dir , 0)
    end
    self.canMove = false
  end

end

function Player:AttackTimer(button)
  if button == 1 then
    self.canMove = true
    self.animation.current:gotoFrame(1)
  end
end

return Player
