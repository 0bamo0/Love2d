love.graphics.setDefaultFilter("nearest", "nearest")

local Menu = require("menu")
local Game = require("game")

function love.load()
    Menu:load()
    Game:load()
end

function love.update(dt)
    if Menu.isActif then
        Menu:update(dt)
    end
    if not Menu.isActif and Menu.GameStart or Menu.Settings then
        Game:update(dt)
    end
end

function love.draw()
    if Menu.isActif then
        Menu:draw()
    end
    if not Menu.isActif and Menu.GameStart then
        Game:draw()
    end
end

function love.keypressed(key)
    if not Menu.isActif and Menu.GameStart then
        Game:keypressed(key)
    end
    Quit(key)
end

function love.keyreleased(key)
    if not Menu.isActif and Menu.GameStart then
        Game:keyreleased(key)
    end
end

function love.mousepressed(x, y, b)
    if not Menu.isActif and Menu.GameStart then
        Game:mousepressed(x, y, b)
    end
end

function love.wheelmoved(x, y)
    if Menu.isActif then
    end
end

function Exit()
    love.event.quit(0)
end

function Quit(key)
  if key == 'escape' and Menu.isActif and not Settings.Showed  then
    Exit()
  end
  if key == 'escape' and not Menu.isActif and Menu.GameStart  then
    Menu:load()
  end
  if key == 'escape' and Settings.Showed then
    print(Settings.Showed)
    Settings.Showed = false
  end
end
