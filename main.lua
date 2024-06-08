if arg[2] == "debug" then
    require("lldebugger").start()
end

Sys_type = love.system.getOS()

love.graphics.setDefaultFilter("nearest", "nearest")

Menu = require("menu")
Game = require("game")


function love.load()
    Gamestat = "Menu"
    if Gamestat == "Menu" then
        Menu:load()
    end
    Game:load()
end

function love.update(dt)
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
end

function love.keypressed(key)
    if key == "o" and Camera.isOnPlayer then
        Camera.isOnPlayer = false
    elseif key == "o" and not Camera.isOnPlayer then
        Camera.isOnPlayer = true
    end
    if Gamestat == "Game" then
        Game:keypressed(key)
    end

    if key == "escape" then
        
        if Gamestat == "Menu" and not Menu.showSetting then
            love.event.quit(0)
        end
        if Gamestat == "Game" then
            Gamestat = "Menu"
            Menu:load()
        end
        if Menu.showSetting then
            Menu.showSetting = false
        end
    end
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
