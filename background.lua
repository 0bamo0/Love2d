local Background = {}
local Camera = require('camera')
local Player = require('player')
local ww,wh = love.graphics.getDimensions()
function Background:load()
    self.stack = {}
    self.static = love.graphics.newImage('assets/Background/1.png')
    self.far = {
      img = love.graphics.newImage('assets/Background/2.png'),
      scale = 0.1
    }
    self.mid = {
      img= love.graphics.newImage('assets/Background/3.png'),
      scale = 0.2
    }
    self.close1 = {
      img = love.graphics.newImage('assets/Background/4.png'),
      scale = 0.3
    }

    table.insert(self.stack , self.far)
    table.insert(self.stack , self.mid)
    table.insert(self.stack , self.close1)

    self.width = self.static:getWidth()
    self.height = self.static:getHeight()
end

function Background:update(dt)

end

function Background:draw()
  local scale = (ww/Camera.scaleX)/self.static:getWidth()
  local x,y = Camera:getField()
  love.graphics.draw(self.static , Camera.x , Camera.y , 0 ,scale)
    for i=0 , 10 do
      love.graphics.draw(self.far.img , (Camera.x/1.05)+(i*self.far.img:getWidth()) ,(wh/Camera.scaleY)-450, 0 , 1)
    end
    for i=0 , 10 do
      love.graphics.draw(self.mid.img , (Camera.x/1.1)+(i*self.mid.img:getWidth()) , (wh/Camera.scaleY)-450 , 0 , 1)
    end
    for i=0 , 10 do
      love.graphics.draw(self.close1.img , (Camera.x/2)+(i*self.close1.img:getWidth()) , (wh/Camera.scaleY)-550 , 0 , 1)
    end
end

return Background
