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

function love.conf(t)
    t.title = "Game name"
    t.console = true
    t.window.fullscreen = false 
    t.window.resizable = true
    t.window.vsync = true

    if hasArg("--test") then
        t.identity = "love2d-tests"
        t.window.width = 320
        t.window.height = 180
        t.window.resizable = false
    end
end
