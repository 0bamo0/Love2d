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
    local cfw , cfh = Camera:getField()
    for i , image in ipairs(self.assets)do
        if image.layer == 1 then
                local scale = math.max(cfh/image.png:getHeight(), cfw/image.png:getWidth()) 
                love.graphics.draw(image.png,Camera.x,Camera.y,0,scale, scale)
        elseif image.layer == 3 then
            for i = -10, 10, 1 do
                local x = i*(image.png:getWidth()*cfh/image.png:getHeight()) + (Camera.x/2)
                love.graphics.draw(image.png,x,Camera.y,0,cfh/image.png:getHeight() , cfh/image.png:getHeight())
            end
        end
    end
end

return Background