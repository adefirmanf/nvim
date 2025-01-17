local function custom_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "f", api.tree.focus, opts("Focus"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      -- default mapping for add (a) , delete (d)
      { "<leader>ee", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle NvimTree" },
      { "<leader>ef", "<cmd>NvimTreeFocus<cr>", desc = "Focus NvimTree" },
    },
    config = function()
      require("nvim-tree").setup({
        on_attach = custom_attach,
        view = {
          width = 50,
        },
      })
    end,
    -- Event.TreeOpen
  },
}
