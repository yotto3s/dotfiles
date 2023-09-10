return function()
	require("modules.utils").load_plugin("filetype", {
		overrides = {
			extensions = {
				purs = "purescript",
			},
		},
	})
end
