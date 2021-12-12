function love.conf(t)
    t.title = "Game name"
    t.window.icon = nil
    t.window.msaa = 0
    t.gammacorrect = true
    t.console = true
    t.window.vsync = false
    t.window.fullscreen = false
    t.window.borderless = false
    t.window.highdpi = true
    t.window.x = nil
    t.window.y = nil
    t.version = "11.3"
    t.window.icon = nil
    if not t.window.fullscreen then t.window.width = 800; t.window.height = 600 end
    t.window.fullscreentype = "desktop"
end
