return {
  "fgheng/winbar.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("winbar").setup({
      enabled = true,

      show_file_path = true,
      show_symbols = true,

      colors = {
        path = "", -- You can customize colors like #c946fd
        file_name = "",
        symbols = "",
      },

      icons = {
        file_icon_default = "",
        seperator = ">",
        editor_state = "●",
        lock_icon = "",
      },

      exclude_filetype = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "NvimTree",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "qf",
      },
    })
  end,
}