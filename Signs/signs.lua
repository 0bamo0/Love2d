local cam = require('camera')

local Signs = {}
Signs.__index = Signs

ActiveSigns = {}

local Signs_Text = require('Signs/signs_text')
function Signs.new(x,y,id)
  local instance = setmetatable({}, Signs)
  instance.x = x
  instance.y = y
  instance.id = id
  instance.stat = 'hide'
  instance.textDuration = 0.2
  instance.textPosition = 0
  instance.font = love.graphics.newImageFont('assets/GUI/Signs/font.png'," abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"")
  instance.textBox = love.graphics.newImage('assets/GUI/Signs/textbox.png')
  instance.collider = world:newRectangleCollider(instance.x , instance.y , 8,16)
  instance.collider:setType('static')
  instance.collider:setCollisionClass('Signs')
  instance.showTimer = 1
  table.insert(ActiveSigns , instance)

end

function Signs:update(dt)
  self.x , self.y = self.collider:getPosition()
  self:setStat(dt)
  self:Timers(dt)
end

function Signs:queryText()
  for i, string in ipairs(Signs_Text) do
    if self.id == string.id then
      return string.text
    end
  end
end

function Signs:draw()
  local fx , fy = self.font:getWidth(self:queryText()) , self.font:getHeight(self:queryText())
  local tw , th = self.textBox:getDimensions()
  print(tw , th)
    if self.stat == 'show' then
      love.graphics.draw(self.textBox , self.x-(tw/12) , self.y-(th/12)-60 , 0 , 1/6 , 1/6)
      love.graphics.printf(string.sub(self:queryText() , 0 , self.textPosition),self.font,self.x-fx/4 , self.y-60 , self.textBox:getWidth(),'left',0 , 0.6 ,0.6)
  end
end

function Signs:setStat(dt)
  if self.collider:enter('Player') then
    self.stat = 'show'
  end
end

function Signs:Timers(dt)
  if self.stat == 'show' then
    self.showTimer = self.showTimer - dt
    self.textDuration = self.textDuration - dt
    cam:lookAt(self.x , self.y)
  end
  if self.showTimer < 0 then
    self.stat = 'hide'
    self.showTimer = 1
    self.textPosition = 0
  end
  if self.textDuration < 0 then
    self.textPosition = self.textPosition + 1
    self.textDuration = 0.1
  end
end

function Signs.drawAll()
  for i,v in ipairs(ActiveSigns)do
    v:draw()
  end
end
function Signs.updateAll(dt)
  for i,v in ipairs(ActiveSigns)do
    v:update(dt)
  end
end
return Signs
