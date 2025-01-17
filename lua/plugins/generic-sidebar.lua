return {
  "sidebar-nvim/sidebar.nvim",
  config = function()
    require("sidebar-nvim").setup({
      files = {
        icon = "",
        show_hidden = true,
        ignored_paths = { "%.git$" },
      },
    })
  end,
}
