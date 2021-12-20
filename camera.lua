local Player = require('player')
local Camera = {}
Camera.x = 0
Camera.y = 0
Camera.layers = {}
Camera.scaleX = 1.6
Camera.scaleY = 1.6
Camera.rotation = 0
Camera.locked = true
local ww,wh = love.graphics.getDimensions()
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
  self.x = x-ww/2/self.scaleX or self.x-ww/2/self.scaleX
  self.y = y-wh/2/self.scaleX or self.y-wh/2/self.scaleX
end

function Camera:getField()
  local fieldW = ww/self.scaleX
  local fieldH = wh/self.scaleY
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
  local fx,fy = self:getField()
  self:lookAtPlayer(dt)
  self:ForceMove()
  if self.x < 0 then
    self.x = 0
  end
  self.y = 80
end

function Camera:ForceMove()
  if not self.locked then
    if love.keyboard.isDown('g') then self:move(-10 , 0) end
    if love.keyboard.isDown('j') then self:move(10 ,0) end
    if love.keyboard.isDown('h') then self:move(0 ,10) end
    if love.keyboard.isDown('y') then self:move(0,-10) end
  end
end

function Camera:setMode(key)
  if key == 't' and self.locked then
    self.locked = false
  elseif key == 't' and not self.locked then
    self.locked = true
  end
end

local function lerp(a, b, t)
  return t < 0.5 and a + (b - a) * t or b + (a - b) * (1 - t)
end
local function damp(a, b, x, dt)
  return lerp(a, b, math.exp(-x * dt))
end

function Camera:lookAtPlayer(dt)
  if self.locked then
    local dx , dy = self:smoothing(Player.x-self.x-ww/2/self.scaleX , Player.y-self.y,1.6)
    self:move(dx, (Player.y-wh/2/self.scaleY)-50)
  end
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
