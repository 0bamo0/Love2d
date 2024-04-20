local Controls = {}

function Controls:load()
    Touches = {}
    local bottomY = love.graphics.getHeight() - 100
    local buttonWidth = 75
    local buttonHeight = 75
    local gap = 15

    self.left = { x = 100, y = bottomY, w = buttonWidth, h = buttonHeight }
    self.right = { x = self.left.x + buttonWidth + gap, y = bottomY, w = buttonWidth, h = buttonHeight }
    self.jump = { x = love.graphics.getWidth() - 100 - buttonWidth, y = bottomY, w = buttonWidth, h = buttonHeight }
end

function Controls:update(dt)
    local bottomY = love.graphics.getHeight() - 100
    local buttonWidth = 75
    local buttonHeight = 75
    local gap = 15

    self.left = { x = 100, y = bottomY, w = buttonWidth, h = buttonHeight }
    self.right = { x = self.left.x + buttonWidth + gap, y = bottomY, w = buttonWidth, h = buttonHeight }
    self.jump = { x = love.graphics.getWidth() - 100 - buttonWidth, y = bottomY, w = buttonWidth, h = buttonHeight }
end

function Controls:draw()
    love.graphics.rectangle("fill", self.left.x, self.left.y, self.left.w, self.left.h)
    love.graphics.rectangle("fill", self.right.x, self.right.y, self.right.w, self.right.h)
    love.graphics.rectangle("fill", self.jump.x, self.jump.y, self.jump.w, self.jump.h)

end

return Controls
