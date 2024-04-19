local Suit = require("libs/Suit")

local Menu = {}
local WindowW, WindowH
local buttonMargin = 16

function Menu:load()
    self:loadAssets()
end

function Menu:loadAssets()
    self.assets = Suit.new()
    self.settings = Suit.new()
    self.showSetting = false
    self.assets.buttons = {}
    
    local buttonInfo = {
        {id = "Start", path = "start"},
        {id = "Options", path = "options"},
        {id = "Exit", path = "exit"}
    }

    for _, info in ipairs(buttonInfo) do
        local button = {
            img = love.graphics.newImage("assets/GUI/Menu/Buttons/" .. info.path .. "_1.png"),
            img2 = love.graphics.newImage("assets/GUI/Menu/Buttons/" .. info.path .. "_2.png"),
            id = info.id
        }
        table.insert(self.assets.buttons, button)
    end
end

function Menu:update(dt)
    if self.showSetting then
        self:drawSettingsButtons()
    else
        self:drawButtons(dt)
    end
end

function Menu:drawSettingsButtons()
    self.settings:Button("Go Back", {id = 1}, WindowW / 2 - WindowW / 6, WindowH / 2 - WindowH / 20, WindowW / 3, WindowH / 10)
    if self.settings:isHit(1) then
        self:buttonClicked("Go Back")
    end
end

function Menu:buttonsTotalHeight()
    local totalHeight = 0
    local buttonPath = "assets/GUI/Menu/Buttons/"
    local directoryItems = love.filesystem.getDirectoryItems(buttonPath)
    
    for _, item in ipairs(directoryItems) do
        local image = love.graphics.newImage(buttonPath .. item)
        totalHeight = totalHeight + image:getHeight()
    end
    
    return totalHeight / 2
end

function Menu:drawButtons(dt)
    local totalHeight = self:buttonsTotalHeight()
    local x = 0
    
    for _, button in ipairs(self.assets.buttons) do
        local bw, bh = button.img:getWidth(), button.img:getHeight()
        local bx, by = WindowW / 2 - (bw / 2), (WindowH / 2) - (totalHeight / 2) + x
        
        self.assets:ImageButton(button.img, {id = button.id, hovered = button.img2}, bx, by)
        x = x + bh + buttonMargin
        
        if self.assets:isHit(button.id) then
            self:buttonClicked(button.id)
        end
    end
end

function Menu:draw()
    love.graphics.setBackgroundColor(166 / 255, 110 / 255, 66 / 255)
    self.assets:draw()
    
    if self.showSetting then
        self.settings:draw()
    end
end

function Menu:buttonClicked(id)
    if id == "Start" then
        Gamestat = "Game"
    elseif id == "Exit" then
        love.event.quit()
    elseif id == "Options" then
        self.showSetting = true
    elseif id == "Go Back" then
        self.showSetting = false
    end
end

return Menu
