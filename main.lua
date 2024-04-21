if arg[2] == "debug" then
    require("lldebugger").start()
end

love.graphics.setDefaultFilter("nearest", "nearest")

Menu = require("menu")
Game = require("game")
Json = require('libs/json')

function love.load()
    Sys_type = love.system.getOS()
    WindowW, WindowH = love.graphics.getDimensions()
    Gamestat = "Menu"
    if Gamestat == "Menu" then
        Menu:load()
    end
    Game:load()
end

function love.update(dt)
    Delta = dt
    WindowW, WindowH = love.graphics.getDimensions()
    if Gamestat == "Menu" then
        Menu:update(dt)
    end
    if Gamestat == "Game" then
        Game:update(dt)
    end
end

function love.draw()
    if Gamestat == "Menu" then
        Menu:draw()
    end
    if Gamestat == "Game" then
        Game:draw()
    end
    love.graphics.print(Delta)
end

function love.keypressed(key)
    if key == "o" and Camera.isOnPlayer then
        Camera.isOnPlayer = false
        print("Camera on")
    elseif key == "o" and not Camera.isOnPlayer then
        Camera.isOnPlayer = true
        print("Camera off")
    end
    if Gamestat == "Game" then
        Game:keypressed(key)
    end
    Quit(key)
end

function love.keyreleased(key)
    if Gamestat == "Game" then
        Game:keyreleased(key)
    end
end

function love.touchpressed( id, x, y, dx, dy, pressure )
    Game:touchpressed(id, x, y, dx, dy, pressure)
    Menu:touchpressed(id, x, y, dx, dy, pressure)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    Game:touchreleased(id, x, y, dx, dy, pressure)
end


function love.mousepressed(x, y, b)
    if Gamestat == "Game" then
        Game:mousepressed(x, y, b)
    end
--if Gamestat == "Menu" then
--    Menu:mousepressed(x, y, b)
--end
end

function love.wheelmoved(x, y)
  if Gamestat == "Game" then
  Game:wheelmoved(x, y)
  end
end

function Quit(key)
    if key == "escape" and Gamestat == "Menu" and not Menu.showSetting then
        Exit()
    end
    if key == "escape" and Gamestat == "Game" then
        Gamestat = "Menu"
        Menu:load()
    end
    if key == "escape" and Menu.showSetting then
        Menu.showSetting = false
    end
end

function Exit()
    love.event.quit(0)
end
