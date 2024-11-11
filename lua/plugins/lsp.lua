return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({ {
        ensure_installed = { "prettier" },
      } })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
          },
        },
      })
      require("lspconfig").gopls.setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
}
