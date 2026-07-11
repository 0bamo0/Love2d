local Suit = require("libs/suit")

local Menu = {}
local buttonMargin = 16
local textButtonHeight = 44

local function drawPixelButton(text, opt, x, y, w, h)
    local state = opt.state or "normal"
    local fill = {0.45, 0.25, 0.13}
    local top = {0.72, 0.44, 0.2}
    local border = {0.16, 0.09, 0.05}
    local textColor = {1, 0.9, 0.58}

    if state == "hovered" then
        fill = {0.55, 0.32, 0.16}
        top = {0.88, 0.56, 0.24}
        textColor = {1, 0.96, 0.72}
    elseif state == "active" or state == "hit" then
        fill = {0.31, 0.18, 0.1}
        top = {0.62, 0.36, 0.16}
    end

    love.graphics.push("all")
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(2)

    love.graphics.setColor(0.08, 0.04, 0.03, 0.8)
    love.graphics.rectangle("fill", x + 5, y + 6, w, h)

    love.graphics.setColor(border)
    love.graphics.rectangle("fill", x, y, w, h)

    love.graphics.setColor(fill)
    love.graphics.rectangle("fill", x + 4, y + 4, w - 8, h - 8)

    love.graphics.setColor(top)
    love.graphics.rectangle("fill", x + 7, y + 7, w - 14, 5)

    love.graphics.setColor(0.24, 0.12, 0.06)
    love.graphics.rectangle("line", x + 6, y + 6, w - 12, h - 12)

    love.graphics.setFont(opt.font)
    love.graphics.setColor(0.1, 0.05, 0.03, 0.75)
    love.graphics.printf(text, x + 3, y + (h - opt.font:getHeight()) / 2 + 2, w, "center")
    love.graphics.setColor(textColor)
    love.graphics.printf(text, x + 2, y + (h - opt.font:getHeight()) / 2, w - 4, "center")

    love.graphics.pop()
end

function Menu:load()
    self:loadAssets()
end

function Menu:loadAssets()
    self.assets = Suit.new()
    self.settings = Suit.new()
    self.loadSlots = Suit.new()
    self.pause = Suit.new()
    self.showSetting = false
    self.screen = "main"
    self.assets.buttons = {}
    self.textButtons = {
        {id = "Runner", label = "Runner"}
    }
    
    local buttonInfo = {
        {id = "Start", path = "start"},
        {id = "Load", path = "load"},
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

function Menu:openMain()
    self.screen = "main"
    self.showSetting = false
end

function Menu:openGamePause()
    self.screen = "GamePause"
    self.showSetting = false
end

function Menu:update(dt)
    if self.screen == "Load" then
        self:drawLoadButtons()
    elseif self.screen == "GamePause" then
        self:drawPauseButtons()
    elseif self.showSetting then
        self:drawSettingsButtons()
    else
        self:drawButtons(dt)
    end
end

function Menu:drawSettingsButtons()
    self.settings:Button("Go Back", {id = 1, draw = drawPixelButton}, WindowW / 2 - WindowW / 6, WindowH / 2 - WindowH / 20, WindowW / 3, WindowH / 10)
    if self.settings:isHit(1) then
        self:buttonClicked("Go Back")
    end
end

function Menu:drawLoadButtons()
    local buttonWidth = math.min(WindowW * 0.7, 360)
    local buttonHeight = 44
    local gap = 14
    local totalHeight = (buttonHeight + gap) * (Game.saveSlotCount + 1)
    local x = WindowW / 2 - buttonWidth / 2
    local y = WindowH / 2 - totalHeight / 2

    for slot = 1, Game.saveSlotCount do
        local label = Game:getSaveSummary(slot)
        self.loadSlots:Button(label, {id = "LoadSlot" .. slot, draw = drawPixelButton}, x, y, buttonWidth, buttonHeight)
        if self.loadSlots:isHit("LoadSlot" .. slot) and Game:LoadGame(slot) then
            Gamestat = "Game"
            self.screen = "main"
        end
        y = y + buttonHeight + gap
    end

    self.loadSlots:Button("Back", {id = "LoadBack", draw = drawPixelButton}, x, y, buttonWidth, buttonHeight)
    if self.loadSlots:isHit("LoadBack") then
        self.screen = "main"
    end
end

function Menu:drawPauseButtons()
    local buttonWidth = math.min(WindowW * 0.7, 360)
    local buttonHeight = 44
    local gap = 14
    local buttonCount = Game.saveSlotCount + 2
    local totalHeight = (buttonHeight + gap) * buttonCount
    local x = WindowW / 2 - buttonWidth / 2
    local y = WindowH / 2 - totalHeight / 2

    self.pause:Button("Resume", {id = "ResumeGame", draw = drawPixelButton}, x, y, buttonWidth, buttonHeight)
    if self.pause:isHit("ResumeGame") then
        Gamestat = "Game"
        self:openMain()
    end
    y = y + buttonHeight + gap

    for slot = 1, Game.saveSlotCount do
        self.pause:Button("Save Slot " .. slot, {id = "SaveSlot" .. slot, draw = drawPixelButton}, x, y, buttonWidth, buttonHeight)
        if self.pause:isHit("SaveSlot" .. slot) then
            Game:SaveGame(slot)
        end
        y = y + buttonHeight + gap
    end

    self.pause:Button("Main Menu", {id = "PauseMain", draw = drawPixelButton}, x, y, buttonWidth, buttonHeight)
    if self.pause:isHit("PauseMain") then
        self:openMain()
    end
end

function Menu:buttonsTotalHeight()
    local totalHeight = 0

    for _, button in ipairs(self.assets.buttons) do
        totalHeight = totalHeight + button.img:getHeight()
    end

    return totalHeight + (#self.textButtons * textButtonHeight)
end

function Menu:touchpressed(id, x, y, dx, dy, pressure)
    
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

    for _, button in ipairs(self.textButtons) do
        local bw, bh = 220, textButtonHeight
        local bx, by = WindowW / 2 - (bw / 2), (WindowH / 2) - (totalHeight / 2) + x
        self.assets:Button(button.label, {id = button.id, draw = drawPixelButton}, bx, by, bw, bh)
        x = x + bh + buttonMargin

        if self.assets:isHit(button.id) then
            self:buttonClicked(button.id)
        end
    end
end

function Menu:draw()
    love.graphics.setBackgroundColor(166 / 255, 110 / 255, 66 / 255)
    love.graphics.setColor(166 / 255, 110 / 255, 66 / 255)
    love.graphics.rectangle("fill", 0, 0, WindowW, WindowH)

    if self.screen == "Load" then
        self.loadSlots:draw()
    elseif self.screen == "GamePause" then
        self.pause:draw()
    elseif self.showSetting then
        self.settings:draw()
    else
        self.assets:draw()
    end
end

function Menu:buttonClicked(id)
    if id == "Start" then
        Gamestat = "Game"
        Game:newGame(Game.currentSaveSlot)
    elseif id == "Load" then
        self.screen = "Load"
    elseif id == "Exit" then
        love.event.quit()
    elseif id == "Options" then
        self.showSetting = true
    elseif id == "Runner" then
        Gamestat = "Runner"
        Runner:newGame()
    elseif id == "Go Back" then
        self.showSetting = false
    end
end

return Menu
