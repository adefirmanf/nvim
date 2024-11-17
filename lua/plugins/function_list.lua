return {
  {
    "function-list",
    dir = "~/.config/nvim/lua/custom_plugins/function-list.lua",
    config = function()
      require("custom_plugins.function-list").setup({})
    end,
  },
}
