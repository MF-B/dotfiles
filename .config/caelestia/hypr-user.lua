-- Personal overrides migrated from the legacy Hyprland conf setup.
local home = os.getenv("HOME")

hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 -d")
end)

hl.config({
    debug = {
        vfr = true,
    },
})

-- Keep the smoother animation timings from the previous config.
hl.animation({ leaf = "layersIn", enabled = true, speed = 7, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 6, bezier = "emphasizedAccel", style = "slide" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 7, bezier = "standard" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 7, bezier = "emphasizedDecel" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "emphasizedAccel" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 8, bezier = "standard" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "standard" })
hl.animation({
    leaf    = "specialWorkspace",
    enabled = true,
    speed   = 6,
    bezier  = "specialWorkSwitch",
    style   = "slidefadevert 15%",
})
hl.animation({ leaf = "fade", enabled = true, speed = 8, bezier = "standard" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 8, bezier = "standard" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "standard" })

-- Fcitx5 candidate popup blur.
hl.layer_rule({ match = { namespace = "fcitx5" }, blur = true })
hl.layer_rule({ match = { namespace = "fcitx5" }, ignore_alpha = 0.1 })

-- Laptop lid switch behaviour.
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/handle-lid.sh close"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/handle-lid.sh open"), { locked = true })
