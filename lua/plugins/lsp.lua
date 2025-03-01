return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "SmiteshP/nvim-navic",               lazy = false },
    { "williamboman/mason.nvim",           config = true }, -- Ensure Mason is installed
    { "williamboman/mason-lspconfig.nvim", config = true }, -- Mason LSP integration
  },
  config = function()
    local lspconfig = require("lspconfig")
    local navic = require("nvim-navic")

    -- Common on_attach function
    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    -- Language server configurations
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          completion = { callSnippet = "Replace" },
          workspace = { checkThirdParty = false },
        },
      },
    })
    lspconfig.gopls.setup({ on_attach = on_attach })
    lspconfig.ruby_lsp.setup({
      on_attach = on_attach,
      cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") }, -- Correct the command to use the ruby shim
    })
    lspconfig.markdown_oxide.setup({ on_attach = on_attach })
    lspconfig.rust_analyzer.setup({})
    lspconfig.gopls.setup({ on_attach = on_attach })
    lspconfig.astro.setup({})
  end,
}
