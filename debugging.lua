local debugging = {}
local Player = require("player")
local Pigs = require("Ennemis/Pigs")
function debugging:load()
    self.isActif = true
end
function debugging:update(dt)
end
function debugging:Switch(key)
    if key == "u" and self.isActif then
        self.isActif = false
    elseif key == "u" and not self.isActif then
        self.isActif = true
    end
end

return debugging
