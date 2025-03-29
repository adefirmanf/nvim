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

  -- Find something 
  { leader("f"), desc = "Find something", group = "Search something", icon = "" },
  { leader("ff"), f(fzf.files), desc = "Find files" },
  { leader("fb"), f(fzf.buffers), desc = "Find buffers" },
  { leader("fr"), f(fzf.resume), desc = "Resume last search" },
  { leader("fg"), f(fzf.live_grep), desc = "Live grep" },
  { leader("fk"), f(fzf.keymaps), desc = "Find keymaps" },
  { leader("fm"), f(fzf.manpages), desc = "Find manpages" },
  { leader("ft"), cmd(":TodoFzfLua"), desc = "Find TODO" },

  { leader("fr"), function() require("custom-plugins.find-replace").setup() end, desc = "Find and replace" },
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

  -- Move line of code
  --
  { mode = { visual, normal }, "<A-Up>", cmd(":m .-2<CR>==g"), desc = "Move line up" },
  { mode = { visual, normal }, "<A-Down>", cmd(":m .+1<CR>==g"), desc = "Move line down" },

  -- Window navigation use number instead of hjkl
  { mode = { visual, normal }, "1", "<C-w>h", desc = "Go to left window" },
  { mode = { visual, normal }, "2", "<C-w>l", desc = "Go to right window" },

  -- Fetch the GH Review
  { leader("gg"), cmd("GhReviews"), desc = "Show pull request reviews" },
  -- Toogle relative number
  { leader("no"), cmd(":set relativenumber!"), desc = "Toggle relative number" },
  -- Set git base branch
  { leader("gb"), function() require("custom-plugins.git-base-neotree").setup() end, desc = "Set git base branch" },
  -- Set TODO Comments
  { leader("tt"), function()
    local cs = vim.bo.commentstring
    local todo_comment
    local local_pos = vim.api.nvim_win_get_cursor(0)

    if cs:match("<!%-%-") then
      -- Special handling for HTML comments
      todo_comment = "<!-- TODO:  -->"
    else
      -- General case for other file types
      todo_comment = cs:gsub("%%s", "") .. " TODO: "
    end
    vim.api.nvim_put({ todo_comment }, "l", false, true)

    local new_col = #todo_comment + 2
    vim.api.nvim_win_set_cursor(0, { local_pos[1], new_col })
  end,
  }
})
