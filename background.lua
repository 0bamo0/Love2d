local Background = {}
local cam = require('camera')
local ww,wh = love.graphics.getDimensions()
function Background:load()
    self.x = 0
    self.y = 0
    self.static = love.graphics.newImage('assets/Background/1.png')
    self.img1 = love.graphics.newImage('assets/Background/2.png')
    self.img2 = love.graphics.newImage('assets/Background/3.png')
    self.img3 = love.graphics.newImage('assets/Background/4.png')
    self.img4 = love.graphics.newImage('assets/Background/5.png')
    self.tileSize = 1107
    self.width = self.static:getWidth()
    self.height = self.static:getHeight()

    self.relX = 0
    self.relY = 0

    self.oldCamX = 0
    self.oldCamY = 0

    self.diffBufferX = 0
    self.diffBufferY = 0

    self.speed = 30
end

function Background:update(dt)
  local camX, camY = cam.x , cam.y
local diffX = camX - self.oldCamX
local diffY = camY - self.oldCamY

-- Background position always at (-768, -768) relative to camera position
self.x = camX - 500
self.y = camY - 350

self.relX = self.relX - (diffX / self.speed)
self.relY = self.relY - (diffY / self.speed/1000)

if self.relX < -self.tileSize then
  self.relX = self.relX + self.tileSize
end

if self.relX > self.tileSize then
  self.relX = self.relX - self.tileSize
end

if self.relY < -self.tileSize then
  self.relY = self.relY + self.tileSize
end

if self.relY > self.tileSize then
  self.relY = self.relY - self.tileSize
end

self.oldCamX = camX
self.oldCamY = camY

print(self.relY)
end

function Background:draw()

  for i=0 , 10 do
    love.graphics.draw(self.img1 , self.x+self.relX+(i*self.img1:getWidth()) , self.y+self.relY+(i*self.img1:getHeight()) , 0 ,1,1)
  end
end

return Background
