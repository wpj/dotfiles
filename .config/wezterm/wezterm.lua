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

    { key = "c", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
    { key = "d", mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },
    { key = "p", mods = "CMD", action = act.ActivateCommandPalette },
    { key = "-", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

    { key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },

    { key = "h", mods = "META", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "j", mods = "META", action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "k", mods = "META", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "l", mods = "META", action = act.AdjustPaneSize({ "Right", 5 }) },

    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

    { key = "f", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },

    { key = "p", mods = "CTRL|SHIFT", action = act.ActivateKeyTable({ name = "move_pane" }) },
    { key = "r", mods = "CTRL|SHIFT", action = act.ActivateKeyTable({ name = "resize_pane" }) },

    { key = "n", mods = "CMD", action = act.SpawnWindow },
    { key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "[", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
    { key = "[", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
    { key = "]", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
    { key = "t", mods = "CTRL|SHIFT", action = act.ShowTabNavigator },

    { key = "w", mods = "CTRL|SHIFT", action = act.ActivateKeyTable({ name = "workspaces" }) },

    { key = "/", mods = "CTRL", action = act.Search("CurrentSelectionOrEmptyString") },

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

    -- Use <S-CR> for multiline input.
    { key = "Enter", mods = "SHIFT", action = act({ SendString = "\x1b\r" }) },
}

config.key_tables = {
    resize_pane = {
        { key = "h", action = act.AdjustPaneSize({ "Left", 5 }) },
        { key = "j", action = act.AdjustPaneSize({ "Down", 5 }) },
        { key = "k", action = act.AdjustPaneSize({ "Up", 5 }) },
        { key = "l", action = act.AdjustPaneSize({ "Right", 5 }) },
        { key = "Escape", action = "PopKeyTable" },
    },
    move_pane = {
        { key = " ", action = act.RotatePanes("Clockwise") },
        { key = "s", action = act.PaneSelect({ mode = "SwapWithActive" }) },
        { key = "Escape", action = "PopKeyTable" },
    },
    workspaces = {
        { key = "w", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
        {
            key = "r",
            action = act.PromptInputLine({
                description = wezterm.format({
                    { Attribute = { Intensity = "Bold" } },
                    { Text = "Rename workspace:" },
                }),
                action = wezterm.action_callback(function(_, _, line)
                    if line then
                        local mux = wezterm.mux
                        mux.rename_workspace(mux.get_active_workspace(), line)
                    end
                end),
            }),
        },
        {
            key = "m",
            action = act.SwitchToWorkspace({
                name = "monitoring",
                spawn = {
                    args = {
                        os.getenv("SHELL"),
                        "-c",
                        "btm",
                    },
                },
            }),
        },
        {
            key = "n",
            action = act.PromptInputLine({
                description = wezterm.format({
                    { Attribute = { Intensity = "Bold" } },
                    { Foreground = { AnsiColor = "Fuchsia" } },
                    { Text = "Enter name for new workspace" },
                }),
                action = wezterm.action_callback(function(window, pane, line)
                    -- line will be `nil` if they hit escape without entering anything
                    -- An empty string if they just hit enter
                    -- Or the actual line of text they wrote
                    if line then
                        window:perform_action(
                            act.SwitchToWorkspace({
                                name = line,
                            }),
                            pane
                        )
                    end
                end),
            }),
        },
    },
}

return config
