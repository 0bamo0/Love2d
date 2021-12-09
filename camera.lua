local Player = require'player'
local cam = camera(0,0)
function cam:Load()
  camToPlayer = true
  self.scale = 1.6
  self:zoom(self.scale)
end

function cam:update(dt)
  local w , h = love.graphics.getWidth() , love.graphics.getHeight()
  if camToPlayer then
    self:lookAt(Player.x , Player.y)
  end
  cam:Movement()

end

function cam:draw()
end

function cam:Zoom(x,y)
  if y > 0 then
      cam:zoom(2)
  elseif y < 0 then
      cam:zoom(0.5)
  end
end

function cam:LockToPlayer(key)
  if key == 'k' and camToPlayer then camToPlayer = false elseif key == 'k' and not camToPlayer then camToPlayer = true end
end
function cam:Movement()
  if love.keyboard.isDown('n') and not camToPlayer then
    cam.x = cam.x + 1
  end
  if love.keyboard.isDown('b') and not camToPlayer then
    cam.y = cam.y + 1
  end
  if love.keyboard.isDown('v') and not camToPlayer then
    cam.x = cam.x - 1
  end
  if love.keyboard.isDown('g') and not camToPlayer then
    cam.y = cam.y - 1
  end
end
return cam
