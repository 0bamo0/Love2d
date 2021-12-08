Player = require'player'
local scale = 1.6
cam = camera(nil , nil , scale)
function cam:Load()
end

function cam:update(dt)
  local w , h = love.graphics.getWidth() , love.graphics.getHeight()
  self:lookAt(Player.x , Player.y)


end

function cam:draw()
end

return cam
