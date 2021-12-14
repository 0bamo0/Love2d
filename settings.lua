Settings ={}
local suit = require("libs/suit")
function Settings:load()
  self.assets = suit.new()
  self.assets.buttons = {}
end

function Settings:update(dt)
  self:addButtons(dt)
end

function Settings:addButtons(dt)
    local x = 0
    local margin = 16
    for i, button in ipairs(self.assets.buttons) do
        local bw = button.img:getWidth()
        local bh = button.img:getHeight()
        local total = self:buttonsTotalHeight()
        local bx = ww / 2 - (bw / 2)
        local by = (wh / 2) - (total / 2)
        self.assets:ImageButton(button.img, {id = button.id, hovered = button.img2}, bx, by + x)
        x = x + bh + margin
        if self.assets:isHit(button.id) then
            self:buttonClicked(button.id)
        end
    end
end
function Settings:draw()
  love.graphics.setColor(166 / 255, 110 / 255, 66 / 255)
  love.graphics.rectangle('fill', 0, 0 , 1000, 1000)
  love.graphics.setColor(1,1,1)
end


return Settings
