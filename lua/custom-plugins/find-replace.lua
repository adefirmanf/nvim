local M = {}
local fzf = require("fzf-lua")

function M.setup()
  local bufnr = vim.api.nvim_get_current_buf() -- Get current buffer

  local function grab_all_cur_buf()
    return table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  end

  fzf.fzf_exec(grab_all_cur_buf(), {
    prompt = "Enter search keyword> ",
    exec_empty_query = true, -- Allow empty query to start input
    actions = {
      ["default"] = function(selected)
        local line_number, match_text = selected[1]:match("^(%d+):(.*)$")
        if not line_number or not match_text then return end
      end
    }
  })
end

return M
