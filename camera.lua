local Player = require "player"
local cam = camera()
function cam:Load()
    camToPlayer = true
    self.scale = 1.6
    self.smoother = {}
    self.speed = 1
end

function cam:update(dt)
  local x , y = self.scale
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    if camToPlayer then
      self:lockPosition(Player.x , Player.y,self.smooth.linear(160))
    end
    if cam.x < w / 3.2 then
        cam.x = w / 3.2
    elseif cam.x < h / 3.2 then
        cam.x = h / 3.2
    end
    cam:Movement()
end

function cam:draw()
end

function cam:Zoom(x, y)
    if y > 0 then
      self.speed = self.speed +10

    elseif y < 0 then
      self.speed = self.speed -10
    end
    print(self.speed)
end

function cam:LockToPlayer(key)
    if key == "k" and camToPlayer then
        camToPlayer = false
    elseif key == "k" and not camToPlayer then
        camToPlayer = true
    end
end
function cam:Movement()
    if love.keyboard.isDown("n") and not camToPlayer then
        cam.x = cam.x + 0.1
    end
    if love.keyboard.isDown("b") and not camToPlayer then
        cam.y = cam.y + 0.1
    end
    if love.keyboard.isDown("v") and not camToPlayer then
        cam.x = cam.x - 0.1
    end
    if love.keyboard.isDown("g") and not camToPlayer then
        cam.y = cam.y - 0.1
    end
end

return cam
