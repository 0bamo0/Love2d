--- The camera module.
-- @module Camera

--- The camera module.
-- @type table
local Camera = {}

--- The x position of the camera.
-- @field x number
Camera.x = 0

--- The y position of the camera.
-- @field y number
Camera.y = 0

--- The x scale of the camera.
-- @field scaleX number
Camera.scaleX = 1.6

--- The y scale of the camera.
-- @field scaleY number
Camera.scaleY = 1.6

--- The rotation of the camera.
-- @field rotation number
Camera.rotation = 0

--- Whether the camera is following the player.
-- @field isOnPlayer boolean
Camera.isOnPlayer = true

--- Set the camera transformation.
-- @function set
function Camera:set()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)
    love.graphics.scale(self.scaleX, self.scaleY)
    love.graphics.translate(-self.x, -self.y)
end

--- Reset the camera transformation.
-- @function unset
function Camera:unset()
    love.graphics.pop()
end

--- Move the camera.
-- @tparam number dx the x displacement
-- @tparam number dy the y displacement
function Camera:move(dx, dy)
    self.x = self.x + (dx or 0)
    self.y = self.y + (dy or 0)
end

--- Rotate the camera.
-- @tparam number dr the rotation angle
function Camera:rotate(dr)
    self.rotation = self.rotation + dr
end

--- Scale the camera.
-- @tparam number sx the x scale factor
-- @tparam number sy the y scale factor
function Camera:scale(sx, sy)
    sx = sx or 1
    self.scaleX = self.scaleX * sx
    self.scaleY = self.scaleY * (sy or sx)
end

--- Set the position of the camera.
-- @tparam number x the x position
-- @tparam number y the y position
function Camera:setPosition(x, y)
    self.x = x - WindowW / 2 / self.scaleX or self.x - WindowW / 2 / self.scaleX
    self.y = y - WindowH / 2 / self.scaleX or self.y - WindowH / 2 / self.scaleX
end

--- Get the size of the camera field.
-- @treturn number the width of the field
-- @treturn number the height of the field
function Camera:getField()
    local fieldW = WindowW / self.scaleX
    local fieldH = WindowH / self.scaleY
    return fieldW, fieldH
end

--- Set the scale of the camera.
-- @tparam number sx the x scale factor
-- @tparam number sy the y scale factor
function Camera:setScale(sx, sy)
    self.scaleX = sx or self.scaleX
    self.scaleY = sy or self.scaleY
end

--- Get the mouse position in camera coordinates.
-- @treturn number the x position
-- @treturn number the y position
function Camera:mousePosition()
    return love.mouse.getX() / self.scaleX + self.x, love.mouse.getY() / self.scaleY + self.y
end

--- Update the camera position.
-- @tparam number dt the time step
function Camera:update(dt)
    if self.isOnPlayer then
        local dx, dy = self:smoothing(
            Player.x - self.x - WindowW / 2 / self.scaleX,
            Player.y - self.y - WindowH / 2 / self.scaleY,
            3
        )
        self:move(dx, dy)
    end
    if self.x < 0 then
        self.x = 0
    end

    if not self.isOnPlayer then
        if love.keyboard.isDown('l') then
            Camera.x = Camera.x + 10
        end
        if love.keyboard.isDown('j') then
            Camera.x = Camera.x - 10
        end
        if love.keyboard.isDown('i') then
            Camera.y = Camera.y - 10
        end
        if love.keyboard.isDown('k') then
            Camera.y = Camera.y + 10
        end
    end
end

--- Calculate smooth movement.
-- @tparam number dx the x displacement
-- @tparam number dy the y displacement
-- @treturn number the smoothed x displacement
-- @treturn number the smoothed y displacement
function Camera:smoothing(dx, dy, s)
    local dts = love.timer.getDelta() * (s)
    return dx * dts, dy * dts
end

--- Zoom the camera.
-- @tparam number x the x zoom factor
-- @tparam number y the y zoom factor
function Camera:Zoom(x, y)
    if y < 0 then
        self:setScale(self.scaleX - 0.1, self.scaleY - 0.1)
    end
    if y > 0 then
        self:setScale(self.scaleX + 0.1, self.scaleY + 0.1)
    end
end

return Camera

