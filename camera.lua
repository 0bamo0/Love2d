local Player = require "player"
local cam = camera()
function cam:Load()
    camToPlayer = true
    self.scale = 1.6
    self.speed = 1
end

function cam:update(dt)
    local x, y = self.scale
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    self:Control(dt)
    if camToPlayer then
        self:lockX(Player.x, self.smooth.damped(1.6))
        self:lockY(Player.y-120, self.smooth.damped(6))
    end
    if cam.x < w / 3.2 then
        cam.x = w / 3.2
    end
    if cam.y > 398 then cam.y = 398 end
end
function cam:LockToPlayer(key)
    if key == "k" and camToPlayer then
        camToPlayer = false
    elseif key == "k" and not camToPlayer then
        camToPlayer = true
    end
end

function cam:Control(dt)
  if not camToPlayer then
    if love.keyboard.isDown('j') then self.x = self.x + 10 end
    if love.keyboard.isDown('h') then self.y = self.y - 10 end
    if love.keyboard.isDown('g') then self.x = self.x - 10 end
    if love.keyboard.isDown('y') then self.y = self.y + 10 end
  end
end

return cam
