love.graphics.setDefaultFilter("nearest", "nearest")

local Menu = require("menu")
local Game = require("game")

function love.load()
  Gamestat = 'Menu'
    Menu:load()
    Game:load()
end

function love.update(dt)
  if Gamestat == 'Menu' then Menu:update(dt) end
  if Gamestat == 'Game' then Game:update(dt) end
end

function love.draw()
  if Gamestat == 'Menu' then Menu:draw() end
  if Gamestat == 'Game' then Game:draw() end
  love.graphics.print('Memory actually used (in mb): ' .. collectgarbage('count')/1024, 10,10)
end

function love.keypressed(key)
  if Gamestat == 'Game' then Game:keypressed(key) end
        Quit(key)
end

function love.keyreleased(key)
  if Gamestat == 'Game' then Game:keyreleased(key) end
end

function love.mousepressed(x, y, b)
  if Gamestat == 'Game' then Game:mousepressed(x, y, b) end
end

function love.wheelmoved(x, y)
end

function Quit(key)
  if key == 'escape' and Gamestat == 'Menu' and not Menu.showSetting then
    Exit()
  end
  if key == 'escape' and Gamestat ~= 'Menu' then
    Gamestat = 'Menu'
    Menu:load()
  end
  if key == 'escape' and Menu.showSetting then
    Menu.showSetting = false
  end
end

function Exit()
    love.event.quit(0)
end
