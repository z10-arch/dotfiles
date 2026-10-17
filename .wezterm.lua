local wezterm = require "wezterm"
local mux = wezterm.mux

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- 1. Set PowerShell 7 as the default shell
-- Note: '-NoLogo' hides the copyright/banner text when opening
config.default_prog = {"pwsh.exe", "-NoLogo"}

-- 2. Disable the tab bar completely
config.enable_tab_bar = false

-- 3. Remove window decorations/borders
config.window_decorations = "NONE"

-- 4. Open in full screen every time
wezterm.on(
    "gui-startup",
    function(cmd)
        local tab, pane, window = mux.spawn_window(cmd or {})
        window:gui_window():toggle_fullscreen()
    end
)

-- 5. Add keybindings (Map Ctrl+V to paste from clipboard, like Shift+Insert)
config.keys = {
    {
        key = "v",
        mods = "CTRL",
        action = wezterm.action.PasteFrom "Clipboard"
    }
}

return config
