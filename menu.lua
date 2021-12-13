local Menu = {}
local ww,wh = love.graphics.getDimensions()
local tween = require('libs/tween')
local shaders = require('shaders')
cam2 = camera()
function Menu:load()
  self.Camera = cam2
  self.timer = 1
  self.isActif = true
  self.buttons = {}
  self.buttons.Start = love.graphics.newImage('assets/GUI/Menu/start_idle.png')
  self.buttons.StartHover = love.graphics.newImage('assets/GUI/Menu/start_hover.png')
  self.buttons.Exit = love.graphics.newImage('assets/GUI/Menu/quit_idle.png')
  self.buttons.ExitHover = love.graphics.newImage('assets/GUI/Menu/quit_hover.png')
  self.buttons.margin = 16
  table.insert(self.buttons, self:newButton('start',self.buttons.Start,self.buttons.StartHover))
  table.insert(self.buttons, self:newButton('exit',self.buttons.Exit,self.buttons.ExitHover))

  pos = {x=ww/2 , y=wh}
  tweenpos = tween.new(1 , pos , {x=ww/2 , y=wh/2} , 'inCubic')
end

function Menu:update(dt)
  tweenpos:update(dt)
  self.Camera:lookAt(pos.x,pos.y)

end

function Menu:newButton( name, img , imgHot)
  return {
    name = name,
    img = img,
    imgHot = imgHot,
    now = false,
    last = false
  }
end

function Menu:draw()
  self.Camera:attach()
  local move = 0
  local margin = 16
  onStart = false
  for i,buttons in ipairs(self.buttons) do
    local img = buttons.img
    local imgW = buttons.img:getWidth()
    local imgH = buttons.img:getHeight()
    local imgx = ww/2-imgW/2
    local imgy = wh/2-imgH+move
    local mx,my = love.mouse.getPosition()
    hot = mx > imgx and mx < imgx+imgW and my > imgy and my < imgy+imgH
    if hot then
      img = buttons.imgHot
    end
    if hot and buttons.name == 'start' then
      onStart = true
    end
    if hot and buttons.name == 'exit' then
      onExit = true
    end
    love.graphics.draw(img , imgx , imgy)
    move = move + imgH + margin
  end
  self.Camera:detach()
end

function Menu:buttonClicked(x,y,key)
  if key == 1 and onStart then
    Menu.isActif = false
  end
  if key == 1 and onExit then
    Exit('escape')
  end
end

return Menu
