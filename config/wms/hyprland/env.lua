local envs = {
	{ "XCURSOR_SIZE", "24" },
	{ "HYPRCURSOR_SIZE", "24" },
	{ "HYPRCURSOR_THEME", "catppuccin-mocha-dark-cursors" },
}

for _, env in ipairs(envs) do
	local var, value = env[1], env[2]
	hl.env(var, value)
end
