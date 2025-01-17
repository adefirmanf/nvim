return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>fd",
      "<cmd>Telescope file_browser<cr>",
      desc = "Telescope File Browser",
    },
  },
}
