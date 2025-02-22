local wk = require("which-key")
local fzf = require("fzf-lua")
-- local cp_neo = require("custom-plugins.git-base-neotree")
-- Function helper
local cmd = function(cmd)
	return "<cmd>" .. cmd .. "<cr>"
end

local leader = function(key)
	return "<leader>" .. key
end

-- Function
local f = function(fn)
	return function()
		fn()
	end
end

-- Normal editor
local normal = "n"
local visual = "v"

-- List of keymaps
wk.add({
	-- Help
	{ leader("?"), cmd("WhichKey"), desc = "WhichKey", group = "Help", icon = "" },
	-- File explorer configuration
	{ leader("e"), cmd("Neotree reveal toggle"), desc = "Toggle Neotree", group = "File explorer", icon = "" },
	{ leader("gg"), cmd("GhReviews"), desc = "Show pull request reviews" },
	-- Find something 
	{ leader("f"), desc = "Find something", group = "Search something", icon = "" },
	{ leader("ff"), f(fzf.files), desc = "Find files" },
	{ leader("fb"), f(fzf.buffers), desc = "Find buffers" },
	{ leader("fr"), f(fzf.resume), desc = "Resume last search" },
	{ leader("ft"), f(fzf.treesitter), desc = "Current treesitter symbol" },
	{ leader("fg"), f(fzf.live_grep), desc = "Live grep" },
	-- Search text in current buffer
	{ mode = { visual, normal }, "<C-f>", f(fzf.lgrep_curbuf), desc = "Live grep current buffer" },
	-- Copy to clipboard
	{ mode = visual, "<C-c>", '"+y', desc = "Copy to clipboard (visual)" },
	{ mode = normal, "<C-c>", '"+yy', desc = "Copy current line to clipboard" }, -- Copy to clipboard (use !pbcopy)
	-- LSP configurationguration
	{ mode = { visual, normal }, "gd", f(vim.lsp.buf.definition), desc = "Go to definition" },
	{ mode = { visual, normal }, "gk", f(vim.lsp.buf.hover), desc = "Show hover" },
	-- Buffer Navigation
	{ "<PageUp>", cmd(":bprev"), desc = "Previous buffer" },
	{ "<PageDown>", cmd(":bnext"), desc = "Next buffer" },
	-- Exit and Save
	{ mode = { visual, normal }, "<C-s>", cmd(":wall"), desc = "Save all" },
	{ mode = { visual, normal }, "<C-q>", cmd(":qall"), desc = "Quit all" },
})
