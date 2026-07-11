Background = {}

function Background:load()
    self.assets = {}

    local directoryItems = love.filesystem.getDirectoryItems("assets/Background")
    
    for i, png in ipairs(directoryItems) do
        local image = {
            png = love.graphics.newImage("assets/Background/".. i ..".png"),
            layer = i
        }

        table.insert(self.assets, image)
    end 
end

function Background:update(dt)
    
end

function Background:draw()
    local width, height = love.graphics.getDimensions()

    love.graphics.push("all")
    love.graphics.origin()

    for i, image in ipairs(self.assets) do
        if image.layer == 1 then
            local scale = math.max(width / image.png:getWidth(), height / image.png:getHeight())
            love.graphics.draw(image.png, 0, 0, 0, scale, scale)
        elseif image.layer == 3 then
            local scale = height / image.png:getHeight()
            local tileWidth = image.png:getWidth() * scale
            local offset = -(Camera.x * 0.28) % tileWidth

            for x = offset - tileWidth, width + tileWidth, tileWidth do
                love.graphics.draw(image.png, x, 0, 0, scale, scale)
            end
        end
    end

    love.graphics.pop()
end

return Background
