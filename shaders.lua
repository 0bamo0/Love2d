local shaders = {}
local moonshine = require('libs/moonshine')
function shaders:load()
  self.effect = moonshine.chain(moonshine.effects.scanlines)

end

function shaders:update(dt)
end

return shaders
