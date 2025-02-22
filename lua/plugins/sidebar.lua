return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		sources = { "filesystem", "buffers", "git_status" },
		source_selector = {
			winbar = true,
			statusline = false,
			sources = {
				{ source = "filesystem", display_name = " Files" },
				{ source = "buffers", display_name = "﬘ Buffers" },
				{ source = "git_status", display_name = " Git" },
			},
		},
		git_status = {
			group_empty_dirs = false,
		},
	},
}
