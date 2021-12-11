local debugging = {}
local Player = require("player")
local Pigs = require("Ennemis/Pigs")
function debugging:load()
    self.isActif = true
end

function debugging:update(dt)
end

function debugging:draw()
    if self.isActif then
        love.graphics.print(Player.xVel)
        if Player.grounded then
            love.graphics.print("On Ground", 0, 10)
        else
            love.graphics.print("Flying", 0, 10)
        end
        if camToPlayer then
            love.graphics.print("Watching Player", 0, 20)
        elseif not camToPlayer then
            love.graphics.print("Free", 0, 20)
        end
    end
end

function debugging:Switch(key)
    if key == "u" and self.isActif then
        self.isActif = false
    elseif key == "u" and not self.isActif then
        self.isActif = true
    end
end

return debugging
