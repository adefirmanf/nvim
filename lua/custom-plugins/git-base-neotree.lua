local M = {}

function M.pick_and_open()
	local fzf_lua = require("fzf-lua")

	-- Fetch Git branches (same as earlier example)
	local function get_git_branches()
		local handle = io.popen("git branch --format='%(refname:short)' 2>/dev/null")
		if not handle then
			return {}
		end
		local branches = {}
		for branch in handle:lines() do
			table.insert(branches, branch)
		end
		handle:close()
		return branches
	end

	-- Launch the picker
	fzf_lua.fzf_exec(get_git_branches(), {
		prompt = "🌿 Git Base Branch> ",
		actions = {
			["default"] = function(selected)
				local branch = selected[1]
				-- Close Neotree first to ensure it reopens fresh
				vim.cmd("Neotree close")
				-- Open with the new git_base branch
				vim.cmd(string.format("Neotree git_status git_base=%s", branch))
			end,
		},
	})
end

return M
