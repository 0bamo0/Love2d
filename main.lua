--- Love2D main.lua file
-- This file contains the main game loop and event handlers

-- Check if the game is running in debug mode
if arg[2] == "debug" then
    require("lldebugger").start()
end

-- Get the operating system type
Sys_type = love.system.getOS()

-- Set the default filter for graphics scaling
love.graphics.setDefaultFilter("nearest", "nearest")

-- Load the menu and game modules
Menu = require("menu")
Game = require("game")

--- Load function
-- This function is called when the game starts
function love.load()
    Gamestat = "Menu" -- Set the initial game state to the menu
    if Gamestat == "Menu" then -- Load the menu if the game state is menu
        Menu:load()
    end
    Game:load() -- Load the game modules
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

    -- Quit the game when the escape key is pressed
    if key == "escape" then
        -- Quit the game if the game state is menu and the settings are not shown
        if Gamestat == "Menu" and not Menu.showSetting then
            love.event.quit(0)
        end
        -- Switch to the menu if the game state is game
        if Gamestat == "Game" then
            Gamestat = "Menu"
            Menu:load()
        end
        -- Hide the settings if they are shown
        if Menu.showSetting then
            Menu.showSetting = false
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
    -- Call the touchpressed function in the game module
    Game:touchpressed(id, x, y, dx, dy, pressure)
    -- Call the touchpressed function in the menu module
    Menu:touchpressed(id, x, y, dx, dy, pressure)
end

--- Touch released event handler
-- This function is called when a touch is released
function love.touchreleased(id, x, y, dx, dy, pressure)
    -- Call the touchreleased function in the game module
    Game:touchreleased(id, x, y, dx, dy, pressure)
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


