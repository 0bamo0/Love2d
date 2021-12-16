local Signs = {}
Signs.__index = Signs

ActiveSigns = {}

local Signs_Text = require("Signs/signs_text")
function Signs.new(x, y, id)
    local instance = setmetatable({}, Signs)
    instance.x = x
    instance.y = y
    instance.id = id
    instance.font =
        love.graphics.newImageFont(
        "assets/GUI/Signs/font.png",
        ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`\'*#=[]"'
    )
    instance.textBox = love.graphics.newImage("assets/GUI/Signs/textbox.png")
    instance.collider = world:newRectangleCollider(instance.x, instance.y, 8, 16)
    instance.collider:setType("static")
    instance.collider:setCollisionClass("Signs")
    instance.textPosition = 0
    table.insert(ActiveSigns, instance)
end

function Signs:update(dt)
    self.x, self.y = self.collider:getPosition()
    self:setStat(dt)
end

function Signs:queryText()
    for i, string in ipairs(Signs_Text) do
        if self.id == string.id then
            return string.text
        end
    end
end

function Signs:draw()
    local fx, fy = self.font:getWidth(self:queryText()), self.font:getHeight(self:queryText())
    local tw, th = self.textBox:getDimensions()
    if self.stat == "hover" then
        if self.id == 1 then
            local x = self.font:getWidth("Press E")
            love.graphics.printf("Press E", self.font, self.x - x / 2, self.y - 40, 75, "left")
        end
        love.graphics.polygon("fill", self.x - 6, self.y - 40, self.x + 6, self.y - 40, self.x, self.y - 45)
    end
    if self.stat == "show" then
        local tx, ty = self.x - (tw / 11), self.y - 125
        if tx < 0 then
            tx = self.x + 10
        end
        local bx, by = self.x - (tw / 10), self.y - (th / 10) - 115
        if bx < 0 then
            bx = self.x
        end
        love.graphics.draw(self.textBox, bx, by, 0, 1 / 4, 1 / 4)
        love.graphics.printf(
            string.sub(self:queryText(), 0, self.textPosition),
            self.font,
            tx,
            ty,
            self.textBox:getWidth() / 2.6,
            "left",
            0,
            0.6,
            0.6
        )
    end
end

function Signs:setStat(dt)
    local query = world:queryCircleArea(self.x, self.y, 20, {"Player"})
    if #query > 0 and love.keyboard.isDown("e") then
        self.stat = "show"
    end
    if #query > 0 and self.stat ~= "show" then
        self.stat = "hover"
    end
    if #query == 0 then
        self.stat = "idle"
        self.textPosition = 0
    end
    if self.stat == "show" then
        self.textPosition = self.textPosition + 1
    end
end

function Signs.drawAll()
    for i, v in ipairs(ActiveSigns) do
        v:draw()
    end
end
function Signs.updateAll(dt)
    for i, v in ipairs(ActiveSigns) do
        v:update(dt)
    end
end
function Signs.removeAll()
    for i, v in ipairs(ActiveSigns) do
        v.collider:destroy()
    end
    ActiveSigns = {}
end
return Signs
