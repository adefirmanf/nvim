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
  { "ray-x/lsp_signature.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local wk = require("which-key")
      --wk.add({
      --       { "<leader>f", group = "search", desc = "Telescope (Find+)" },
      --})
      -- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      local lspconfig_defaults = require("lspconfig").util.default_config
      lspconfig_defaults.capabilities =
        vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP Actions",
        callback = function(event)
          local opts = { buffer = event.buf }
          wk.add({
            { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration", mode = "n", opts = opts },
            { "gd", vim.lsp.buf.definition, desc = "Go to Definition", mode = "n", opts = opts },
            { "K", vim.lsp.buf.hover, desc = "Hover reference", mode = "n", opts = opts },
            { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help", mode = "n", opts = opts },
          })

          require("lsp_signature").on_attach({
            -- ... setup options here ...
          }, opts.buffer)
        end,
      })
    end,
  },
}
