--- Love2D main.lua file
-- This file contains the main game loop and event handlers

local function hasArg(value)
    if not arg then
        return false
    end

    for _, item in pairs(arg) do
        if item == value then
            return true
        end
    end

    return false
end

if hasArg("--test") then
    require("tests.runner")
    return
end

-- Check if the game is running in debug mode
if hasArg("debug") then
    require("lldebugger").start()
end

-- Get the operating system type
Sys_type = love.system.getOS()

-- Set the default filter for graphics scaling
love.graphics.setDefaultFilter("nearest", "nearest")

-- Load the menu and game modules
Menu = require("menu")
Game = require("game")
Runner = require("runner")

--- Load function
-- This function is called when the game starts
function love.load()
    Gamestat = "Menu" -- Set the initial game state to the menu
    if Gamestat == "Menu" then -- Load the menu if the game state is menu
        Menu:load()
    end
    Game:load() -- Load the game modules
    Runner:load()
end

--- Update function
-- This function is called every frame to update the game state
function love.update(dt)
    WindowW, WindowH = love.graphics.getDimensions() -- Get the window dimensions
    if Gamestat == "Menu" then -- Update the menu if the game state is menu
        Menu:update(dt)
    end
    if Gamestat == "Game" then -- Update the game if the game state is game
        Game:update(dt)
    end
    if Gamestat == "Runner" then
        Runner:update(dt)
    end
end

--- Draw function
-- This function is called every frame to draw the game state to the screen
function love.draw()
    if Gamestat == "Menu" then -- Draw the menu if the game state is menu
        Menu:draw()
    end
    if Gamestat == "Game" then -- Draw the game if the game state is game
        Game:draw()
    end
    if Gamestat == "Runner" then
        Runner:draw()
    end
end

--- Key pressed event handler
-- This function is called when a key is pressed
function love.keypressed(key)
    -- Switch between following the player and not following the player when the "o" key is pressed
    if key == "o" and Camera.isOnPlayer then
        Camera.isOnPlayer = false
    elseif key == "o" and not Camera.isOnPlayer then
        Camera.isOnPlayer = true
    end
    -- Call the keypressed function in the game module if the game state is game
    if Gamestat == "Game" then
        Game:keypressed(key)
    end
    if Gamestat == "Runner" then
        Runner:keypressed(key)
    end

    -- Quit the game when the escape key is pressed
    if key == "escape" then
        if Gamestat == "Game" then
            Gamestat = "Menu"
            Menu:openGamePause()
            return
        end
        if Gamestat == "Runner" then
            Gamestat = "Menu"
            Menu:openMain()
            return
        end
        if Gamestat == "Menu" and Menu.screen == "GamePause" then
            Gamestat = "Game"
            Menu:openMain()
            return
        end
        if Gamestat == "Menu" and Menu.screen == "Load" then
            Menu:openMain()
            return
        end
        if Menu.showSetting then
            Menu.showSetting = false
            return
        end
        -- Quit the game if the game state is menu and the settings are not shown
        if Gamestat == "Menu" then
            love.event.quit(0)
        end
    end
end

--- Key released event handler
-- This function is called when a key is released
function love.keyreleased(key)
    -- Call the keyreleased function in the game module if the game state is game
    if Gamestat == "Game" then
        Game:keyreleased(key)
    end
end

--- Touch pressed event handler
-- This function is called when a touch is pressed
function love.touchpressed( id, x, y, dx, dy, pressure )
    if Gamestat == "Game" then
        Game:touchpressed(id, x, y, dx, dy, pressure)
    elseif Gamestat == "Runner" then
        Runner:touchpressed(id, x, y, dx, dy, pressure)
    elseif Gamestat == "Menu" then
        Menu:touchpressed(id, x, y, dx, dy, pressure)
    end
end

--- Touch released event handler
-- This function is called when a touch is released
function love.touchreleased(id, x, y, dx, dy, pressure)
    if Gamestat == "Game" then
        Game:touchreleased(id, x, y, dx, dy, pressure)
    elseif Gamestat == "Runner" then
        Runner:touchreleased(id, x, y, dx, dy, pressure)
    end
end

--- Mouse pressed event handler
-- This function is called when a mouse button is pressed
function love.mousepressed(x, y, b)
    -- Call the mousepressed function in the game module if the game state is game
    if Gamestat == "Game" then
        Game:mousepressed(x, y, b)
    end
end

--- Mouse wheel moved event handler
-- This function is called when the mouse wheel is moved
function love.wheelmoved(x, y)
    -- Call the wheelmoved function in the game module if the game state is game
    if Gamestat == "Game" then
        Game:wheelmoved(x, y)
    end
end


