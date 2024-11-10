return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope Search grep live" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope Help tags" },
    },
  },
}
