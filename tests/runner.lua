local tests = {}

local function test(name, fn)
    table.insert(tests, {name = name, fn = fn})
end

local function fail(message)
    error(message or "assertion failed", 2)
end

local function assertTruthy(value, message)
    if not value then
        fail(message or "expected value to be truthy")
    end
end

local function assertFalsy(value, message)
    if value then
        fail(message or "expected value to be falsy")
    end
end

local function assertEqual(actual, expected, message)
    if actual ~= expected then
        fail((message or "values are not equal") .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
    end
end

local function resetModules()
    local modules = {
        "game",
        "map",
        "player",
        "Ennemis/Pigs",
        "camera",
        "debugging",
        "Signs/signs",
        "controls",
        "background",
        "menu",
        "runner"
    }

    for _, moduleName in ipairs(modules) do
        package.loaded[moduleName] = nil
    end

    for _, globalName in ipairs({
        "Game",
        "Map",
        "Player",
        "Pigs",
        "Camera",
        "debugging",
        "Signs",
        "Controls",
        "Background",
        "Runner",
        "world",
        "Touches",
        "ActiveSigns",
        "Gamestat"
    }) do
        _G[globalName] = nil
    end
end

local function freshGame()
    resetModules()

    _G.Sys_type = love.system.getOS()
    _G.WindowW, _G.WindowH = love.graphics.getDimensions()
    love.graphics.setDefaultFilter("nearest", "nearest")

    local Game = require("game")
    Game:load()

    return Game, _G.Map, _G.Player, _G.Pigs, _G.Camera
end

local function getUpvalue(fn, upvalueName)
    local index = 1

    while true do
        local name, value = debug.getupvalue(fn, index)
        if not name then
            return nil
        end
        if name == upvalueName then
            return value
        end
        index = index + 1
    end
end

test("game loads level, world, and player collider", function()
    local _, Map, Player = freshGame()

    assertEqual(Map.currentLevel, 1, "initial level")
    assertTruthy(Player.collider and Player.collider.body, "player collider should exist")
    assertTruthy(world.collision_classes.Player, "player collision class should exist")
    assertTruthy(#world.box2d_world:getBodies() > 0, "world should contain physics bodies")
end)

test("combat hitboxes emit enter events without physical blocking", function()
    freshGame()

    local pig = world:newRectangleCollider(100, 100, 16, 16)
    pig:setCollisionClass("Pigs")
    pig:setType("dynamic")

    local attack = world:newRectangleCollider(100, 100, 16, 16)
    attack:setCollisionClass("AttackCollider")
    attack:setType("static")

    local player = world:newRectangleCollider(150, 100, 16, 16)
    player:setCollisionClass("Player")
    player:setType("dynamic")

    local pigAttack = world:newRectangleCollider(150, 100, 16, 16)
    pigAttack:setCollisionClass("PigsAttack")
    pigAttack:setType("static")

    world:update(1 / 60)

    assertTruthy(pig:enter("AttackCollider"), "pig should receive player attack enter event")
    assertTruthy(player:enter("PigsAttack"), "player should receive pig attack enter event")
end)

test("player attack cleanup handles repeated clicks", function()
    freshGame()

    Sys_type = "Windows"
    Player.stuned = false
    Player.isAttcking = false
    Player.animation.current = Player.animation.attack

    Player:Attack(1)
    local firstAttackCollider = Player.AttackCollider
    assertTruthy(firstAttackCollider and firstAttackCollider.body, "first attack collider should exist")

    Player:Attack(1)
    local latestAttackCollider = Player.AttackCollider
    Player.attacktimer = -0.01

    local ok, err = pcall(function()
        Player:Timers(0)
    end)

    assertTruthy(ok, err)
    assertFalsy(firstAttackCollider.body, "old attack collider should be destroyed or reused safely")
    if latestAttackCollider ~= firstAttackCollider then
        assertFalsy(latestAttackCollider.body, "latest attack collider should be destroyed when the attack ends")
    end
end)

test("pig cleanup removes active attack hitboxes", function()
    freshGame()

    Pigs.new(40, 40, 16, 16, 10, 1)
    local activePigs = getUpvalue(Pigs.updateAll, "ActivePigs")
    local pig = activePigs[#activePigs]

    pig.attackCollider = world:newRectangleCollider(40, 40, 12, 12)
    pig.attackCollider:setCollisionClass("PigsAttack")
    pig.attackCollider:setType("static")

    local attackCollider = pig.attackCollider
    Pigs.removeAll()

    assertFalsy(pig.collider.body, "pig body should be destroyed")
    assertFalsy(attackCollider.body, "pig attack collider should be destroyed")
end)

test("save slots restore independently", function()
    local Game, _, Player = freshGame()

    for slot = 1, Game.saveSlotCount do
        Game:deleteSave(slot)
    end

    Player.health = 3
    Player.x = 123
    Player.y = 456
    Game:SaveGame(1)

    Player.health = 8
    Player.x = 321
    Player.y = 654
    Game:SaveGame(2)

    Player.health = 10
    Game:LoadGame(1)

    assertEqual(Player.health, 3, "loaded health")
    assertEqual(Player.x, 123, "slot 1 x")
    assertEqual(Player.y, 456, "slot 1 y")

    Game:LoadGame(2)

    assertEqual(Player.health, 8, "slot 2 health")
    assertEqual(Player.x, 321, "slot 2 x")
    assertEqual(Player.y, 654, "slot 2 y")

    for slot = 1, Game.saveSlotCount do
        Game:deleteSave(slot)
    end
end)

test("loading an empty save slot fails cleanly", function()
    local Game = freshGame()

    Game:deleteSave(3)

    assertFalsy(Game:LoadGame(3), "empty slot should not load")
end)

test("touch release ignores unknown touch ids", function()
    freshGame()
    Player.isMovingLeft = true

    local ok, err = pcall(function()
        Player:touchreleased(999, 0, 0, 0, 0, 0)
    end)

    assertTruthy(ok, "unknown touch release should not crash: " .. tostring(err))
end)

test("menu layout does not reload images every frame", function()
    resetModules()
    _G.WindowW, _G.WindowH = love.graphics.getDimensions()

    local Menu = require("menu")
    Menu:load()

    local originalNewImage = love.graphics.newImage
    local calls = 0
    love.graphics.newImage = function(...)
        calls = calls + 1
        return originalNewImage(...)
    end

    local ok, err = pcall(function()
        Menu:buttonsTotalHeight()
    end)

    love.graphics.newImage = originalNewImage

    assertTruthy(ok, err)
    assertEqual(calls, 0, "buttonsTotalHeight should use cached button images")
end)

test("map max-y helper scans every level-control object", function()
    local _, Map = freshGame()

    Map.lvlControlLayer = {
        objects = {
            {y = 100},
            {y = 50},
            {y = 200}
        }
    }

    assertEqual(Map:getMaxYCoord(), 200, "maximum y")
end)

test("player is grounded when standing across multiple colliders", function()
    freshGame()

    Player.x = 300
    Player.y = 300
    Player.width = 20
    Player.height = 20
    Player.collider.body:setPosition(Player.x, Player.y)

    local groundA = world:newRectangleCollider(290, 310, 10, 4)
    groundA:setCollisionClass("Ground")
    groundA:setType("static")

    local groundB = world:newRectangleCollider(300, 310, 10, 4)
    groundB:setCollisionClass("Ground")
    groundB:setType("static")

    Player:Collisions(0)

    assertTruthy(Player.grounded, "ground detection should accept one or more supporting colliders")
end)

test("touch movement respects stun state", function()
    freshGame()

    Player.collider:setLinearVelocity(0, 0)
    Player.yVel = 0
    Player.isMovingRight = true
    Player.stuned = true
    Player.wallsRight = false
    Player.canMove = true

    Player:Move(0)
    local xVel = Player.collider:getLinearVelocity()

    assertEqual(xVel, 0, "stunned player should not move from touch input")
end)

test("game pause menu is separate from main menu", function()
    resetModules()
    _G.WindowW, _G.WindowH = love.graphics.getDimensions()

    local Menu = require("menu")
    Menu:load()
    Menu:openGamePause()

    assertEqual(Menu.screen, "GamePause", "pause screen")
    Menu:openMain()
    assertEqual(Menu.screen, "main", "main screen")
end)

test("keyboard movement persists after state update", function()
    freshGame()

    local originalIsDown = love.keyboard.isDown
    love.keyboard.isDown = function(...)
        local keys = {...}
        for _, key in ipairs(keys) do
            if key == "right" then
                return true
            end
        end
        return false
    end

    Player.collider:setLinearVelocity(0, 0)
    Player.yVel = 0
    Player.wallsRight = false
    Player.canMove = true
    Player.stuned = false

    local ok, err = pcall(function()
        Player:Move(0)
        Player:setStat(0)
    end)

    love.keyboard.isDown = originalIsDown

    assertTruthy(ok, err)
    local xVel = Player.collider:getLinearVelocity()
    assertEqual(xVel, Player.speed, "right movement should survive setStat")
end)

test("camera zoom cannot cross zero scale", function()
    freshGame()

    Camera:setScale(0.05, 0.05)
    Camera:Zoom(0, -1)

    assertTruthy(Camera.scaleX > 0 and Camera.scaleY > 0, "camera scale should stay positive")
end)

test("runner jumps and advances distance", function()
    resetModules()

    local Runner = require("runner")
    Runner:load()
    local startingDistance = Runner.distance

    Runner:keypressed("space")
    assertTruthy(Runner.player.vy < 0, "runner jump velocity")

    Runner:update(0.1)

    assertTruthy(Runner.distance > startingDistance, "runner distance should advance")
end)

test("runner detects obstacle collision", function()
    resetModules()

    local Runner = require("runner")
    Runner:load()
    Runner.obstacles = {
        {
            x = Runner.player.x,
            y = Runner.player.y,
            w = Runner.player.w,
            h = Runner.player.h
        }
    }

    Runner:update(0.016)

    assertTruthy(Runner.dead, "runner should end on obstacle collision")
end)

local function writeResults(summary)
    local source = love.filesystem.getSource()
    local resultPath = source .. "/tests/results.txt"
    local file = assert(io.open(resultPath, "w"))
    file:write(table.concat(summary, "\n"))
    file:write("\n")
    file:close()
end

function love.load()
    local summary = {}
    local passed = 0
    local failed = 0

    table.insert(summary, "Love2D test run")
    table.insert(summary, string.rep("=", 15))

    for _, case in ipairs(tests) do
        local ok, err = xpcall(case.fn, debug.traceback)

        if ok then
            passed = passed + 1
            table.insert(summary, "PASS " .. case.name)
        else
            failed = failed + 1
            table.insert(summary, "FAIL " .. case.name)
            table.insert(summary, err)
        end
    end

    table.insert(summary, "")
    table.insert(summary, "Passed: " .. passed)
    table.insert(summary, "Failed: " .. failed)

    writeResults(summary)
    love.event.quit(failed == 0 and 0 or 1)
end
