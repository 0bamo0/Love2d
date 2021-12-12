local Player = require "player"
local cam = camera()
local tween = require('libs/tween')
function cam:Load()
    camToPlayer = true
    self.scale = 2
    self.speed = 1
end

function cam:update(dt)
  local x , y = self.scale
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    if camToPlayer then
      self:lockX(Player.x,self.smooth.damped(1.6))
      self:lockY(Player.y,self.smooth.damped(1))
    end
    if cam.x < w / 4 then
        cam.x = w / 4
    elseif cam.x < h / 4 then
        cam.x = h / 4
    end
end
function cam:LockToPlayer(key)
    if key == "k" and camToPlayer then
        camToPlayer = false
    elseif key == "k" and not camToPlayer then
        camToPlayer = true
    end
end

return cam
