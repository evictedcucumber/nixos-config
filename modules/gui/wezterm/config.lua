local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font")

config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 4,
	right = 2,
	top = 8,
	bottom = 8,
}

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.audible_bell = "Disabled"
wezterm.on("bell", function() end)

config.default_cursor_style = "SteadyBar"

config.automatically_reload_config = false

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe" }
end

return config
