return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	opts = {
		defaults = {
			no_header = true
		},
		files = {
			rg_glob = true,
			hidden = false,
			rg_opts = "--color=always --smart-case --files --glob '!.git/' --glob '!.*' --fixed-strings",
			fzf_opts = {
				["--exact"] = true
			}
		},
		grep = {
			rg_opts = "--color=always --smart-case -g '!{.git,node_modules,target}/*'",
			rg_glob = true,
		},
	}

}
