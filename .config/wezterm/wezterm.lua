local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- Settings
config.color_scheme = "Tokyo Night"

config.inactive_pane_hsb = {
    -- saturation = 0.5,
    brightness = 0.7,
}

config.font = wezterm.font({ family = "Inconsolata Nerd Font" })
config.font_size = 18.0
config.bold_brightens_ansi_colors = true

config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

config.scrollback_lines = 10000

-- Key mappings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 }
config.keys = {
    -- Send C-a when C-a is pressed twice.
    {
        key = "a",
        mods = "LEADER|CTRL",
        action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
    },

    { key = "c", mods = "LEADER", action = act.ActivateCopyMode },
    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = " ", mods = "LEADER", action = act.RotatePanes("Clockwise") },

    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

    { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane" }) },

    { key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "t", mods = "LEADER", action = act.ShowTabNavigator },

    { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

    { key = "/", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },

    -- Clear the scrollback/viewport and send C-l to redraw the prompt.
    {
        key = "l",
        mods = "CTRL",
        action = act.Multiple({
            act.ClearScrollback("ScrollbackAndViewport"),
            act.SendKey({ key = "l", mods = "CTRL" }),
        }),
    },
}

config.key_tables = {
    resize_pane = {
        { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
        { key = "Escape", action = "PopKeyTable" },
    },
}

return config
