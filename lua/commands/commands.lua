-- Custom commands --
-- Toggle neotree location when buffer open
--
-- vim.api.nvim_create_augroup("NeotreeCustom", { clear = true })
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	group = "NeotreeCustom",
-- 	callback = function()
-- 		local bufname = vim.api.nvim_buf_get_name(0) -- Get the file path
-- 		if bufname == "" then
-- 			return -- Exit if no file is opened
-- 		end
--
-- 		-- Only reveal in Neo-tree if it's already open and only in "Files" window
--
-- 		local neo_tree_state = require("neo-tree.sources.manager").get_state("filesystem")
-- 		vim.notify("Neo-tree state: " .. vim.inspect(neo_tree_state), vim.log.levels.ERROR)
--
-- 		for _, win in ipairs(vim.api.nvim_list_wins()) do
-- 			local buf = vim.api.nvim_win_get_buf(win)
-- 			if vim.bo[buf].filetype == "neo-tree" then
-- 				vim.defer_fn(function()
-- 					vim.cmd("Neotree reveal reveal_force_cwd") -- Reveal file inside Neo-tree
-- 					vim.cmd("wincmd p") -- Return to previous window
-- 				end, 50)
-- 				return
-- 			end
-- 		end
-- 	end,
-- })
--
--
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if vim.tbl_contains({ 'null-ls' }, client.name) then     -- blacklist lsp
      return
    end
    require("lsp_signature").on_attach({
      -- ... setup options here ...
    }, bufnr)
  end,
})
