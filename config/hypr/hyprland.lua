local mainMod = "SUPER"
local terminal = "foot"
local menu = "fuzzel"

---- AUTOSTART ----
hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("sleep 1 && waypaper --restore")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("mako")
    hl.exec_cmd("polkit-agent")
end)
---- ENVIRONMENT ----
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")

---- LOOK AND FEEL ----
hl.config({
    general = {
        gaps_in = 4,
        gaps_out = { top = 5, right = 8, bottom = 8, left = 8 },
        border_size = 1,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border   = "rgba(aabcc199)",
            inactive_border = "rgba(48575c88)",
        },
	},
    decoration = {
        rounding = 8,
        blur = {
            enabled = true,
            size = 5,
            passes = 1,
            vibrancy = 0.2,
        },
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

hl.curve("easeOut", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })
hl.animation({ leaf = "windows",    enabled = true, speed = 5, bezier = "easeOut" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "easeOut" })
hl.animation({ leaf = "border",     enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default", style = "slidefade" })

---- INPUT ----
hl.config({
    input = {
        kb_layout = "gb",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

---- KEYBINDINGS ----
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill -USR1 -f waybar"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("loginctl lock-session"))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("waypaper"))


---- WINDOW RULES ----
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- translucent windows, solid when fullscreen
hl.window_rule({
    match = { class = ".*" },
    opacity = "0.9 override",
})

hl.window_rule({
    match = { class = ".*", fullscreen = true },
    opacity = "1.0 override",
})

hl.window_rule({
    name = "float-waypaper",
    match = { class = ".*waypaper.*" },
    float = true,
    center = true,
    size = "900 600",
})

-- blur behind the bar and launcher
hl.layer_rule({
    match = { namespace = "waybar" },
    blur = true,
    ignore_alpha = 0.15,
})

hl.layer_rule({
    match = { namespace = "launcher" },  -- fuzzel's default namespace
    blur = true,
    ignore_alpha = 0.15,
})

hl.layer_rule({
    match = { namespace = "notifications" },  -- the name mako gives its popups
    blur = true,
    ignore_alpha = 0.15,
})

---- MONITOR ----
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1.0,
})
