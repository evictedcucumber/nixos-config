local envs = {
	{ "XCURSOR_SIZE", "24" },
	{ "XCURSOR_THEME", "BreezeX-RosePine-Linux" },
	{ "HYPRCURSOR_SIZE", "24" },
	{ "HYPRCURSOR_THEME", "rose-pine-hyprcursor" },
	{ "XDG_CURRENT_DESKTOP", "Hyprland" },
}

for _, env in ipairs(envs) do
	local var, value = env[1], env[2]
	hl.env(var, value)
end
