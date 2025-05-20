local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- Settings
config.color_scheme = "Tokyo Night"

config.inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.7,
}

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.font = wezterm.font({ family = "Berkeley Mono" })
config.font_size = 16.0
config.bold_brightens_ansi_colors = true

config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

config.scrollback_lines = 10000

config.disable_default_key_bindings = true
config.adjust_window_size_when_changing_font_size = false

config.check_for_updates = false

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
    { key = "d", mods = "LEADER", action = act.ShowDebugOverlay },
    { key = "P", mods = "LEADER", action = act.ActivateCommandPalette },
    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

    { key = "p", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_pane" }) },
    { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane" }) },

    { key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "[", mods = "SHIFT|CMD", action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "SHIFT|CMD", action = act.ActivateTabRelative(1) },
    { key = "[", mods = "LEADER", action = act.MoveTabRelative(-1) },
    { key = "]", mods = "LEADER", action = act.MoveTabRelative(1) },
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

    { mods = "CMD", key = "q", action = act.QuitApplication },
    { mods = "CMD", key = "t", action = act.SpawnTab("CurrentPaneDomain") },
    { mods = "CMD", key = "w", action = act.CloseCurrentPane({ confirm = true }) },
    { mods = "CMD", key = "c", action = act.CopyTo("Clipboard") },
    { mods = "CMD", key = "v", action = act.PasteFrom("Clipboard") },
    { mods = "ALT", key = "-", action = act.DecreaseFontSize },
    { mods = "ALT", key = "=", action = act.IncreaseFontSize },
    { mods = "ALT", key = "0", action = act.ResetFontSize },
    { mods = "CMD", key = "1", action = act.ActivateTab(0) },
    { mods = "CMD", key = "2", action = act.ActivateTab(1) },
    { mods = "CMD", key = "3", action = act.ActivateTab(2) },
    { mods = "CMD", key = "4", action = act.ActivateTab(3) },
    { mods = "CMD", key = "5", action = act.ActivateTab(4) },
}

config.key_tables = {
    resize_pane = {
        { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
        { key = "Escape", action = "PopKeyTable" },
    },
    move_pane = {
        { key = " ", action = act.RotatePanes("Clockwise") },
        { key = "s", action = act.PaneSelect({ mode = "SwapWithActive" }) },
        { key = "Escape", action = "PopKeyTable" },
    },
}


return config
