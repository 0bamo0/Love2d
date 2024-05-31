local Camera = {}
Camera.x = 0
Camera.y = 0
Camera.scaleX = 1.6
Camera.scaleY = 1.6
Camera.rotation = 0
Camera.isOnPlayer = true

function Camera:set()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)
    love.graphics.scale(self.scaleX,self.scaleY)
    love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
    love.graphics.pop()
end

function Camera:move(dx, dy)
    self.x = self.x + (dx or 0)
    self.y = self.y + (dy or 0)
end

function Camera:rotate(dr)
    self.rotation = self.rotation + dr
end

function Camera:scale(sx, sy)
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end

function Camera:setPosition(x, y)
  self.x = x-WindowW/2/self.scaleX or self.x-WindowW/2/self.scaleX
  self.y = y-WindowH/2/self.scaleX or self.y-WindowH/2/self.scaleX
end

function Camera:getField()
  local fieldW = WindowW/self.scaleX
  local fieldH = WindowH/self.scaleY
  return fieldW , fieldH
end

function Camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end

function Camera:mousePosition()
  return love.mouse.getX() / self.scaleX + self.x, love.mouse.getY() / self.scaleY + self.y
end

function Camera:update(dt)
  if self.isOnPlayer then
      local dx , dy = self:smoothing(Player.x-self.x-WindowW/2/self.scaleX , Player.y-self.y-WindowH/2/self.scaleY,3)
      self:move(dx,dy)
  end
  if self.x < 0 then
    self.x = 0
  end

  if not self.isOnPlayer then
    if love.keyboard.isDown('l') then
      Camera.x = Camera.x + 10
    end
    if love.keyboard.isDown('j') then
      Camera.x = Camera.x - 10
    end
    if love.keyboard.isDown('i') then
      Camera.y = Camera.y - 10
    end
    if love.keyboard.isDown('k') then
      Camera.y = Camera.y + 10
    end

  end
end

local function lerp(a, b, t)
  return t < 0.5 and a + (b - a) * t or b + (a - b) * (1 - t)
end
local function damp(a, b, x, dt)
  return lerp(a, b, math.exp(-x * dt))
end


function Camera:smoothing(dx,dy, s)
  local dts = love.timer.getDelta() * (s or stiffness)
  return dx*dts, dy*dts
end


function Camera:Zoom(x,y)
  if y < 0 then self:setScale(self.scaleX-0.1,self.scaleY-0.1) end
  if y > 0 then self:setScale(self.scaleX+0.1,self.scaleY+0.1) end
end

return Camera
