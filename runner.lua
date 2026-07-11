local Runner = {}

local function rectsOverlap(a, b)
    return a.x < b.x + b.w and
        b.x < a.x + a.w and
        a.y < b.y + b.h and
        b.y < a.y + a.h
end

function Runner:load()
    self.background = love.graphics.newImage("assets/Background/1.png")
    self.clouds = love.graphics.newImage("assets/Background/3.png")
    self.playerSheet = love.graphics.newImage("assets/Player/PlayerSheet-2.png")
    self.playerQuad = love.graphics.newQuad(0, 0, 78, 58, self.playerSheet:getWidth(), self.playerSheet:getHeight())
    self.pigSheet = love.graphics.newImage("assets/pig.png")
    self.pigQuad = love.graphics.newQuad(0, 0, 33, 28, self.pigSheet:getWidth(), self.pigSheet:getHeight())
    self:newGame()
end

function Runner:newGame()
    local width, height = love.graphics.getDimensions()
    self.groundY = height - 92
    self.player = {
        x = math.max(130, width * 0.18),
        y = self.groundY - 66,
        w = 58,
        h = 66,
        vy = 0,
        grounded = true
    }
    self.gravity = 2100
    self.jumpVelocity = -760
    self.speed = 330
    self.maxSpeed = 660
    self.spawnTimer = 0.9
    self.distance = 0
    self.score = 0
    self.best = self.best or 0
    self.dead = false
    self.obstacles = {}
end

function Runner:spawnObstacle()
    local width = love.graphics.getWidth()
    local obstacleWidth = 70
    local obstacleHeight = 54
    local obstacle = {
        kind = "pig",
        x = width + 30,
        y = self.groundY - obstacleHeight,
        w = obstacleWidth,
        h = obstacleHeight
    }
    table.insert(self.obstacles, obstacle)
end

function Runner:jump()
    if self.dead then
        self:newGame()
        return
    end

    if self.player.grounded then
        self.player.vy = self.jumpVelocity
        self.player.grounded = false
    end
end

function Runner:update(dt)
    local width, height = love.graphics.getDimensions()
    local oldGroundY = self.groundY
    self.groundY = height - 92
    if oldGroundY and oldGroundY ~= self.groundY then
        self.player.y = self.player.y + (self.groundY - oldGroundY)
    end

    if self.dead then
        return
    end

    self.speed = math.min(self.speed + 10 * dt, self.maxSpeed)
    self.distance = self.distance + self.speed * dt
    self.score = math.floor(self.distance / 10)
    self.best = math.max(self.best, self.score)

    self.player.vy = self.player.vy + self.gravity * dt
    self.player.y = self.player.y + self.player.vy * dt
    if self.player.y + self.player.h >= self.groundY then
        self.player.y = self.groundY - self.player.h
        self.player.vy = 0
        self.player.grounded = true
    end

    self.spawnTimer = self.spawnTimer - dt
    if self.spawnTimer <= 0 then
        self:spawnObstacle()
        self.spawnTimer = love.math.random(75, 130) / 100
    end

    local playerBox = {
        x = self.player.x + 4,
        y = self.player.y + 4,
        w = self.player.w - 8,
        h = self.player.h - 8
    }

    for i = #self.obstacles, 1, -1 do
        local obstacle = self.obstacles[i]
        obstacle.x = obstacle.x - self.speed * dt
        if obstacle.x + obstacle.w < 0 then
            table.remove(self.obstacles, i)
        elseif rectsOverlap(playerBox, obstacle) then
            self.dead = true
        end
    end
end

function Runner:drawBackground()
    local width, height = love.graphics.getDimensions()
    local bgScale = math.max(width / self.background:getWidth(), height / self.background:getHeight())
    love.graphics.draw(self.background, 0, 0, 0, bgScale, bgScale)

    local cloudScale = height / self.clouds:getHeight()
    local cloudWidth = self.clouds:getWidth() * cloudScale
    local offset = -(self.distance * 0.18) % cloudWidth
    for x = offset - cloudWidth, width + cloudWidth, cloudWidth do
        love.graphics.draw(self.clouds, x, 0, 0, cloudScale, cloudScale)
    end
end

function Runner:drawGround()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    love.graphics.setColor(0.35, 0.24, 0.15)
    love.graphics.rectangle("fill", 0, self.groundY, width, height - self.groundY)

    love.graphics.setColor(0.26, 0.18, 0.12)
    for y = self.groundY + 18, height, 26 do
        love.graphics.rectangle("fill", 0, y, width, 4)
    end

    love.graphics.setColor(0.34, 0.52, 0.13)
    love.graphics.rectangle("fill", 0, self.groundY - 8, width, 12)
    love.graphics.setColor(0.48, 0.64, 0.18)
    love.graphics.rectangle("fill", 0, self.groundY - 11, width, 4)

    love.graphics.setColor(0.2, 0.14, 0.1)
    local offset = -(self.distance * 0.45) % 80
    for x = offset - 80, width + 80, 80 do
        love.graphics.rectangle("fill", x, self.groundY + 28, 30, 7)
    end

    love.graphics.setColor(1, 1, 1)
end

function Runner:draw()
    self:drawBackground()
    self:drawGround()

    for _, obstacle in ipairs(self.obstacles) do
        local scale = obstacle.h / 28
        love.graphics.draw(self.pigSheet, self.pigQuad, obstacle.x - 4, obstacle.y - 4, 0, scale, scale)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.playerSheet, self.playerQuad, self.player.x - 40, self.player.y - 24, 0, 1.8, 1.8)
    love.graphics.print("Score " .. self.score, 20, 20)
    love.graphics.print("Best " .. self.best, 20, 42)

    if self.dead then
        love.graphics.printf("Game Over", 0, love.graphics.getHeight() / 2 - 32, love.graphics.getWidth(), "center")
        love.graphics.printf("Press Space", 0, love.graphics.getHeight() / 2 - 8, love.graphics.getWidth(), "center")
    end
end

function Runner:keypressed(key)
    if key == "space" or key == "up" or key == "w" then
        self:jump()
    elseif key == "r" then
        self:newGame()
    end
end

function Runner:touchpressed(id, x, y, dx, dy, pressure)
    self:jump()
end

function Runner:touchreleased(id, x, y, dx, dy, pressure)
end

return Runner
