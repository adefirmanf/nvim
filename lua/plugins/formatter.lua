return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { "markdownlint" },
      ruby = { "robocop" },
      rust = { "rustfmt" },
      go = { "gofmt" },
      astro = { "prettier" },
      html = { "prettier" },
      js = { "prettier" }
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
