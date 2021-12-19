local Player = require('player')
local Camera = {}
Camera.x = 0
Camera.y = 150-32
Camera.layers = {}
Camera.scaleX = 0.6
Camera.scaleY = 0.6
Camera.rotation = 0
Camera.locked = true
local ww,wh = love.graphics.getDimensions()
function Camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1./self.scaleX,1/self.scaleY)
  love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
  love.graphics.pop()
end

function Camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
  if self.x < 0 then
    self.x = 0
  end
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
  self.x = x or self.x
  self.y = y or self.y
  if self.x < 0 then
    self.x = 0
  end
end

function Camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end

function Camera:mousePosition()
  return love.mouse.getX() / self.scaleX + self.x, love.mouse.getY() / self.scaleY + self.y
end


function Camera:update(dt)
  print(self.x , self.y)
  self:ForceMove()
  self:lookAtPlayer()
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

function Camera:lookAtPlayer()
  if self.locked then
    self:setPosition(Player.x-ww/2*0.6)
  end
end

return Camera
