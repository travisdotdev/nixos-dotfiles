
local mainMod = "SUPER"
local terminal = "foot"
local menu = "hyprlauncher"


---- AUTOSTART ----
hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
end)

---- ENVIRONMENT ----
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

---- LOOK AND FEEL ----
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 3,
        border_size = 1,
        col = {
            active_border = { colors = {"rgba(7dcfffee)", "rgba(ad8ee6ee)"}, angle = 45 },
            inactive_border = "rgba(32344aaa)",
        },
        resize_on_border = true,
        layout = "dwindle",
    },
    decoration = {
        rounding = 5,
        active_opacity = 1.0,
        inactive_opacity = 0.94,
        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            new_optimizations = true,
            vibrancy = 0.17,
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
    },
})

---- INPUT ----
hl.config({
    input = {
        kb_layout = "gb",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

-- 3-finger swipe to switch workspaces
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

---- KEYBINDINGS ----
-- Apps
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) 

-- Focus with arrows
hl.bind(mainMod .. " + h ",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l ", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j",  hl.dsp.focus({ direction = "down" }))

-- Workspaces: Super+1..0 switch, Super+Shift+1..0 move window
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

-- Move/resize windows by dragging with Super + left/right mouse button
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Function keys (needs brightnessctl + playerctl in home.packages)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

---- WINDOW RULES ----
hl.window_rule({
    name = "float-pavucontrol",
    match = { class = "org.pulseaudio.pavucontrol" },
    float = true,
})

-- ignore apps' maximize requests
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- From the official example: fix XWayland drag glitches
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

hl.config({
	monitor = {
		{ name = "", resolution = "preferred", position = "auto", scale = 0.5 },
	},
})
