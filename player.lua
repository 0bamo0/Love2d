local Player = {}

function Player:load()
    self:LoadAssets()
    self.x = 100
    self.y = 210
    self.direction = 1
    self.stat = "idle"
    self.speed = 200
    self.width = 25
    self.height = 27
    self.health = 10
    self.jumpForce = 580
    self.hurtTimer = 0.5
    self.attacktimer = 0.28
    self.deathtimer = 1.1
    self.spawnTimer = 1
    self.dashTimer = 0.8
    self.collider = world:newBSGRectangleCollider(self.x, self.y, self.width, self.height, 10)
    self.collider:setCollisionClass("Player")
    self.collider:setFixedRotation(true)
    self.collider:setMass(1)
    self.collider:setType("dynamic")
    self.collider:setPreSolve(OneWayPlatforms)

    self.grounded = false
    self.onPlatform = false
    self.canMove = true
    self.isHurt = false
    self.Respawing = false
    self.isAttcking = false
    self.isDead = false

end

function Player:update(dt)
    self.xVel, self.yVel = self.collider:getLinearVelocity()
    self.wallsLeft = false
    self.wallsRight = false
    self:Collisions(dt)
    self:setDirection(dt)
    self:Move(dt)
    self:setStat(dt)
    self:Hurt()
    self:Timers(dt)
    self:Animate(dt)
    self:fellIntoTheRiver(dt)
end

function Player:Move(dt)
    if (love.keyboard.isDown("right", "d") and not self.wallsRight and self.canMove and not self.stuned) or self.isMovingRight then
        self.collider:setLinearVelocity(self.speed, self.yVel)
      end
    if (love.keyboard.isDown("left", "q") and not self.wallsLeft and self.canMove and not self.stuned) or self.isMovingLeft then
        self.collider:setLinearVelocity(-self.speed, self.yVel)
    end
    self.x, self.y = self.collider:getPosition()
end

function Player:Friction(key)
    self.xVel, self.yVel = self.collider:getLinearVelocity()
    if (key == "right" or key == "q" or key == "left" or key == "d") then
        self.collider:setLinearVelocity(0, self.yVel)
        self.animation.current:gotoFrame(1)
    end
end

function Player:LoadAssets()
    self.sheet = love.graphics.newImage("assets/Player/PlayerSheet-2.png")
    self.grid = anim8.newGrid(78, 58, self.sheet:getWidth(), self.sheet:getHeight(), 0, 0, 0)
    self.animation = {}
    self.animation.idle = anim8.newAnimation(self.grid("1-11", 1), 0.1)
    self.animation.run = anim8.newAnimation(self.grid("15-22",1), 0.1)
    self.animation.attack = anim8.newAnimation(self.grid("23-25", 1), 0.1)
    self.animation.death = anim8.newAnimation(self.grid("28-31", 1), 0.1)
    self.animation.hurt = anim8.newAnimation(self.grid("26-27", 1), 0.1)
    self.animation.jump = anim8.newAnimation(self.grid("12-13", 1), 0.1)
    self.animation.fall = anim8.newAnimation(self.grid("14-14", 1), 0.1)
end

function Player:Animate(dt)
        self.animation.current = self.animation[self.stat]
        self.animation.current:update(dt)
end

function Player:draw()
    self.animation.current:draw(self.sheet, self.x, self.y, 0, self.direction, 1, 31, 30)
end

function Player:setDirection(dt)
    if self.xVel < 0 then
        self.direction = -1
    elseif self.xVel > 0 then
        self.direction = 1
    end
end

function Player:setStat(dt)
    if self.yVel < 0 then
        self.stat = "jump"
    elseif self.yVel > 0 then
        self.stat = "fall"
    end

    if self.grounded or self.onPlatform then
        if self.xVel ~= 0 then
            self.stat = "run"
        else
            self.stat = "idle"
        end
    end
    if self.xVel > 300 then
        self.xVel = 300
    elseif self.xVel < -300 then
        self.xVel = -300
    end
    if self.yVel > 300 then
        self.yVel = 300
    elseif self.yVel < -300 then
        self.yVel = -300
    end
end

function Player:Collisions(dt)
    local queryX = self.x - self.width / 2
    local queryY = self.y + self.height / 2
    local query = world:queryRectangleArea(queryX, queryY, self.width, 1, {"Ground", "Platforms", "Walls"})
    if #query == 1 then
        self.grounded = true
    else
        self.grounded = false
    end

    if self.direction == 1 then
        local queryX = self.x + self.width / 2
        local queryY = self.y - self.height / 2
        local query2Right = world:queryRectangleArea(queryX, queryY, 1, self.height, {"Ground", "Platforms", "Walls"})
        if #query2Right == 1 then
            self.wallsRight = true
        else
            self.wallsRight = false
        end
    end

    if self.direction == -1 then
        local queryX = self.x - self.width / 2 - 1
        local queryY = self.y - self.height / 2
        local query2Left = world:queryRectangleArea(queryX, queryY, 1, self.height, {"Ground", "Platforms", "Walls"})
        if #query2Left == 1 then
            self.wallsLeft = true
        else
            self.wallsLeft = false
        end
    end
end

function Player:Hurt()
    if self.collider:enter("PigsAttack") then
        self.isHurt = true
        self.collider:setLinearVelocity(-self.direction * 200, -100)
        self.health = self.health - 1
        if self.health == 0 then
          self.isDead = true
        end
    end
end

function Player:Jump(key)
    if key == "space" and not self.stuned then
        if (self.grounded or self.onPlatform) then
            self.collider:applyLinearImpulse(self.xVel, -self.jumpForce)
        end
    end
end

function Player:fellIntoTheRiver(dt)
  --oooh noooo
  if self.collider:enter('Death') then
  self.isDead = true
end
end



function Player:resetPosition()
    self.collider.body:setPosition(self.startX, self.startY)
    self.collider:applyLinearImpulse(0, 10000000)
    self.Respawning = true
end


function Player:Attack(b)
    if b == 1 and Sys_type == "Windows" then
        if not self.stuned then
            self.isAttcking = true
            if self.direction == 1 then
                self.AttackCollider =
                    world:newRectangleCollider(self.x + self.width - 15, self.y - self.height / 2, 25, self.height)
            elseif self.direction == -1 then
                self.AttackCollider = world:newRectangleCollider(self.x - 45, self.y - self.height / 2, 25, self.height)
            end
            self.AttackCollider:setCollisionClass("AttackCollider")
            self.AttackCollider:setType("static")
        end
    end
end

function Player:touchpressed(id, x, y, dx, dy, pressure)
    Touches[id] = {id = ""}
    if x > Controls.left.x and x < Controls.left.x + Controls.left.w and y > Controls.left.y and y < Controls.left.y + Controls.left.h then
        Touches[id].id = "left"
        self.isMovingLeft = true
        self.isMovingRight = false
    elseif x > Controls.right.x and x < Controls.right.x + Controls.right.w and y > Controls.right.y and y < Controls.right.y + Controls.right.h  then
        Touches[id].id = "right"
        self.isMovingRight = true
        self.isMovingLeft = false
    elseif x > Controls.jump.x and x < Controls.jump.x + Controls.jump.w and y > Controls.jump.y and y < Controls.jump.y + Controls.jump.h  then
        if (self.grounded or self.onPlatform) then
            Touches[id].id = "jump"
            self.collider:applyLinearImpulse(self.xVel, -self.jumpForce)
        end
    end
end


function Player:touchreleased(id, x, y, dx, dy, pressure)
    if self.isMovingLeft and Touches[id].id == "left" then
        self.isMovingLeft = false
    elseif self.isMovingRight and Touches[id].id == "right" then
        self.isMovingRight = false
    end
end

function Player:Timers(dt)
    if self.Respawning then
        self.stuned = true
        self.spawnTimer = self.spawnTimer - dt
    end
    if self.spawnTimer < 0 then
        self.stuned = false
        self.Respawning = false
        self.spawnTimer = 1
    end
    if self.isAttcking then
        self.attacktimer = self.attacktimer - dt
        self.stat = "attack"
        self.stuned = true
    end
    if self.attacktimer < 0 then
        self.AttackCollider:destroy()
        self.stuned = false
        self.isAttcking = false
        self.attacktimer = 0.3
        self.animation.current:gotoFrame(3)
    end
    if self.isHurt then
        self.stuned = true
        self.hurtTimer = self.hurtTimer - dt
        self.stat = "hurt"
    end
    if self.hurtTimer < 0 then
        self.isHurt = false
        self.hurtTimer = 0.5
        self.stuned = false
    end
    if self.isDead then
      self.stuned = true
      self.stat = 'death'
      self.deathtimer = self.deathtimer - dt
    end
    if self.deathtimer < 0 then
      self.isDead = false
      self.health = 10
      self:resetPosition()
      self.deathtimer = 1.1
      self.animation.current:gotoFrame(1)
    end
end
return Player
