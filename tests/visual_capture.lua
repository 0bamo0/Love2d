local scenarios = {}
local current = 1
local captured = false
local waitingFrames = 0

local function screenshotPath(name)
    return love.filesystem.getSource() .. "/tests/screenshots/" .. name .. ".png"
end

local function writeScreenshot(name, imageData)
    local fileData = imageData:encode("png")
    local file = assert(io.open(screenshotPath(name), "wb"))
    file:write(fileData:getString())
    file:close()
end

local function addScenario(name, setup, draw, update)
    table.insert(scenarios, {
        name = name,
        setup = setup,
        draw = draw,
        update = update
    })
end

local function setupGame(scale)
    Gamestat = "Game"
    Camera:setScale(scale, scale)
    Camera.isOnPlayer = true
    Game:newGame(1)
    for i = 1, 20 do
        Game:update(1 / 60)
    end
end

local function drawGame()
    Game:draw()
end

local function drawMenu()
    Menu:draw()
end

local function drawRunner()
    Runner:draw()
end

function love.load()
    Sys_type = love.system.getOS()
    WindowW, WindowH = love.graphics.getDimensions()
    love.graphics.setDefaultFilter("nearest", "nearest")

    Menu = require("menu")
    Game = require("game")
    Runner = require("runner")

    Menu:load()
    Game:load()
    Runner:load()

    addScenario("game_default", function()
        setupGame(1.6)
    end, drawGame)

    addScenario("game_zoomed", function()
        setupGame(2.4)
    end, drawGame)

    addScenario("runner", function()
        Gamestat = "Runner"
        Runner:newGame()
        Runner.obstacles = {}
        Runner:spawnObstacle()
        Runner.obstacles[1].x = love.graphics.getWidth() * 0.68
        Runner:update(0.1)
    end, drawRunner)

    addScenario("runner_exit_confirm", function()
        Gamestat = "Runner"
        Runner:newGame()
        Runner:spawnObstacle()
        Runner.obstacles[1].x = love.graphics.getWidth() * 0.68
        Runner:update(0.1)
        Runner:requestExit()
    end, drawRunner)

    addScenario("pause_menu", function()
        Gamestat = "Menu"
        Menu:openGamePause()
        Menu:update(0)
    end, drawMenu, function(dt)
        Menu:update(dt)
    end)

    addScenario("load_menu", function()
        Gamestat = "Menu"
        Menu:openMain()
        Menu.screen = "Load"
        Menu:update(0)
    end, drawMenu, function(dt)
        Menu:update(dt)
    end)

    scenarios[current].setup()
end

function love.update(dt)
    WindowW, WindowH = love.graphics.getDimensions()

    local scenario = scenarios[current]
    if scenario and scenario.update then
        scenario.update(dt)
    end

    if captured then
        waitingFrames = waitingFrames + 1
        if waitingFrames > 2 then
            current = current + 1
            captured = false
            waitingFrames = 0

            if not scenarios[current] then
                love.event.quit(0)
                return
            end
            scenarios[current].setup()
        end
    end
end

function love.draw()
    local scenario = scenarios[current]
    if not scenario then
        return
    end

    scenario.draw()

    if not captured then
        love.graphics.captureScreenshot(function(imageData)
            writeScreenshot(scenario.name, imageData)
            captured = true
        end)
    end
end
