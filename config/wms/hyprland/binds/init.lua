require("binds.gestures")

local ipc = "noctalia msg"

local mouse_binds = {
	{ "SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true } },
	{ "SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true } },
}

local launcher_binds = {
	{ "SUPER + T", hl.dsp.exec_cmd("ghostty") },
	{ "SUPER + E", hl.dsp.exec_cmd("nautilus") },
	{ "SUPER + B", hl.dsp.exec_cmd("helium") },
	{ "SUPER + SPACE", hl.dsp.exec_cmd(ipc .. " panel-toggle launcher") },
	{ "SUPER + comma", hl.dsp.exec_cmd(ipc .. " settings-toggle") },
	{ "SUPER + L", hl.dsp.exec_cmd(ipc .. " session lock") },
	{ "SUPER + X", hl.dsp.exec_cmd(ipc .. " panel-toggle session") },
	-- { "CTRL + SHIFT + ESCAPE", hl.dsp.exec_cmd(ipc .. " systemMonitor toggle") },
	{ "SUPER + SHIFT + S", hl.dsp.exec_cmd("flameshot gui") },
}

local window_binds = {
	{ "SUPER + W", hl.dsp.window.close() },
	{ "SUPER + V", hl.dsp.window.float() },
	{ "SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }) },
	{ "SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }) },
	{ "SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }) },
	{ "SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }) },
}

local workspace_binds = {
	{ "SUPER + 1", hl.dsp.focus({ workspace = "1" }) },
	{ "SUPER + 2", hl.dsp.focus({ workspace = "2" }) },
	{ "SUPER + 3", hl.dsp.focus({ workspace = "3" }) },
	{ "SUPER + 4", hl.dsp.focus({ workspace = "4" }) },
	{ "SUPER + 5", hl.dsp.focus({ workspace = "5" }) },
	{ "SUPER + 6", hl.dsp.focus({ workspace = "6" }) },
	{ "SUPER + 7", hl.dsp.focus({ workspace = "7" }) },
	{ "SUPER + 8", hl.dsp.focus({ workspace = "8" }) },
	{ "SUPER + 9", hl.dsp.focus({ workspace = "9" }) },
	{ "SUPER + 0", hl.dsp.focus({ workspace = "10" }) },
	{ "SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1", follow = true }) },
	{ "SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2", follow = true }) },
	{ "SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3", follow = true }) },
	{ "SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4", follow = true }) },
	{ "SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5", follow = true }) },
	{ "SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6", follow = true }) },
	{ "SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7", follow = true }) },
	{ "SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8", follow = true }) },
	{ "SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9", follow = true }) },
	{ "SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10", follow = true }) },
	-- { "SUPER + S", hl.dsp.workspace.toggle_special("magic") },
	-- { "SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }) },
}

local special_binds = {
	{ "XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume-mute"), { locked = true } },
	{ "XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume-up"), { repeating = true } },
	{ "XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume-down"), { repeating = true } },
	{ "XF86AudioPlay", hl.dsp.exec_cmd(ipc .. " media toggle"), { locked = true } },
	{ "XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness-up"), { repeating = true, locked = true } },
	{ "XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness-down"), { repeating = true, locked = true } },
}

local function join(...)
	local result = {}
	for _, t in ipairs({ ... }) do
		for _, v in ipairs(t) do
			result[#result + 1] = v
		end
	end
	return result
end

local binds = join(mouse_binds, launcher_binds, window_binds, workspace_binds, special_binds)

for _, bind in ipairs(binds) do
	local keys, dispatch, opts = bind[1], bind[2], bind[3] or {}
	hl.bind(keys, dispatch, opts)
end
