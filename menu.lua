local Menu = {}
local ww, wh = love.graphics.getDimensions()
local suit = require("libs/suit")
function Menu:load()
    self:LoadAssets()
end

function Menu:LoadAssets()
    self.assets = suit.new()
    self.Settings = suit.new()
    self.showSetting = false
    self.assets.buttons = {}
    self.assets.buttonStart = {
        img = love.graphics.newImage("assets/GUI/Menu/Buttons/start_1.png"),
        img2 = love.graphics.newImage("assets/GUI/Menu/Buttons/start_2.png"),
        id = "Start"
    }
    self.assets.buttonOptions = {
        img = love.graphics.newImage("assets/GUI/Menu/Buttons/options_1.png"),
        img2 = love.graphics.newImage("assets/GUI/Menu/Buttons/options_2.png"),
        id = "Options"
    }
    self.assets.buttonExit = {
        img = love.graphics.newImage("assets/GUI/Menu/Buttons/exit_1.png"),
        img2 = love.graphics.newImage("assets/GUI/Menu/Buttons/exit_2.png"),
        id = "Exit"
    }

    table.insert(self.assets.buttons, self.assets.buttonStart)
    table.insert(self.assets.buttons, self.assets.buttonOptions)
    table.insert(self.assets.buttons, self.assets.buttonExit)
end

function Menu:update(dt)

    if self.showSetting then
      self:drawSettingsButtons()
    end
    if not self.showSetting then
      self:drawButtons(dt)
    end
end

function Menu:drawSettingsButtons()
  self.Settings:Button('Go Back',{id=1},ww/2-ww/6 , wh/2-wh/20 , ww/3 ,wh/10)
  if self.Settings:isHit(1) then
    self:buttonClicked('Go Back')
  end

end

function Menu:buttonsTotalHeight()
    local bth = 0
    local n = love.filesystem.getDirectoryItems("assets/GUI/Menu/Buttons")
    for i, item in ipairs(n) do
        local x = love.graphics.newImage("assets/GUI/Menu/Buttons/" .. item)
        bth = bth + x:getHeight()
    end
    return bth / 2
end

function Menu:drawButtons(dt)
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

function Menu:draw()
    love.graphics.setBackgroundColor(166 / 255, 110 / 255, 66 / 255)
    self.assets:draw()
    if self.showSetting then
      self.Settings:draw()
    end
end

function Menu:buttonClicked(x,dt)
    if x == "Start" then
      Gamestat = 'Game'
    end
    if x == "Exit" then
        Exit()
    end
    if x == 'Options' then
      self.showSetting = true
    end
    if x == 'Go Back' then
      self.showSetting = false
    end
end


return Menu
