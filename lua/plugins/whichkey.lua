return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>f", group = "search", desc = "Telescope (Find+)" },
      })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      -- Custom Explore shortcut key
      {
        "<leader>E",
        "<cmd>Explore<cr>",
        desc = "Explore",
      },
    },
  },
}