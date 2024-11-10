return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- Lua style
          lua = { "stylua" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = {
          -- Format on save
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
      require("conform").formatters.stylua = {}
    end,
  },
}
