local window_rules = {
	{
		name = "suppress-maximize-events",
		match = { class = ".*" },
		suppress_event = "maximize",
	},
	{
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
	},
}

local layer_rules = {
	{
		name = "noctalia",
		match = { namespace = "noctalia-background-.*$" },
		ignore_alpha = 0.5,
		blur = true,
		blur_popups = true,
	},
}

for _, w_rule in ipairs(window_rules) do
	hl.window_rule(w_rule)
end

for _, l_rule in ipairs(layer_rules) do
	hl.layer_rule(l_rule)
end
