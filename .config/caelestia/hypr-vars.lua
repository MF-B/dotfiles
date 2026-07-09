local scheme = require("scheme.current")

return {
    terminal             = "foot",
    browser              = "flatpak run app.zen_browser.zen",
    editor               = "foot vim",
    fileExplorer         = "nautilus",

    blurEnabled          = false,

    shadowRange          = 12,
    shadowRenderPower    = 2,
    shadowColour         = "rgba(" .. scheme.shadow .. "33)",

    windowGapsIn         = 10,
    windowGapsOut        = 40,
    windowRounding       = 10,
    windowBorderSize     = 3,

    volumeStep           = 2,
}
