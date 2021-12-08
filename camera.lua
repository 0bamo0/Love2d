Player = require'player'
cam = camera(nil , nil , 1.6)
function cam:Load()
end

function cam:update(dt)
  self:lookAt(Player.x , Player.y)
end

function cam:draw()
end

return cam
