-- toggle telescope when there are diagnostic errors

local function toggle_telescope(diagnostic_files)
  local opts = {
    prompt_title = "Diagnostic Error",
    sorting_strategy = "ascending", -- Controls sorting and position of prompt
    layout_config = {
      preview_cutoff = 2,
      height = 0.2, -- Adjust height if needed
      prompt_position = "bottom", -- Positions prompt at top
    },
    previewer = true,
  }

  local results = {}
  local colors = require("catppuccin.palettes").get_palette()
  local TelescopeColor = {
    TelescopeMatching = { fg = colors.flamingo },
    TelescopeSelection = { fg = colors.red },

    TelescopePromptPrefix = { bg = colors.surface0 },
    TelescopePromptNormal = { bg = colors.surface0 },
    TelescopeResultsNormal = { bg = colors.mantle },
    TelescopePreviewNormal = { bg = colors.mantle },
    TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
    TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
    TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
    TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
    TelescopeResultsTitle = { fg = colors.flamingo },
    TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
  }

  for hl, col in pairs(TelescopeColor) do
    vim.api.nvim_set_hl(0, hl, col)
  end
  for _, v in ipairs(diagnostic_files) do
    if v.severity == vim.diagnostic.severity.ERROR then
      local entry = {
        --       display_text = string.format("%%#%s#%s", "TelescopeError", v.message),
        display_text = string.format("%s:%d | %s", vim.fn.fnamemodify(v.bufnr, ":t"), v.lnum + 1, v.message),
        ordinal = v.message,
        line = v.lnum,
        col = v.col,
        buffer = v.bufnr,
        path = vim.api.nvim_buf_get_name(v.bufnr),
      }
      table.insert(results, entry)
    end
  end

  vim.defer_fn(function()
    require("telescope.pickers")
      .new(opts, {
        prompt_title = "LSP Diagnostic - Error",
        finder = require("telescope.finders").new_table({
          results = results,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.display_text,
              ordinal = entry.ordinal,
              path = entry.path,
              lnum = entry.line + 1,
              buffer = entry.buffer,
            }
          end,
        }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(_, map)
          map("i", "<CR>", function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            require("telescope.actions").close(prompt_bufnr)

            -- Move cursor to the diagnostic location
            vim.api.nvim_set_current_buf(selection.value.buffer)
            vim.api.nvim_win_set_cursor(0, { selection.value.line + 1, selection.value.col })
          end)
          return true
        end,
        previewer = require("telescope.config").values.grep_previewer({}),
      })
      :find()
  end, 0)
end

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

      -- go to declaration
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

      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("golang-autocmd", { clear = true }),
        pattern = "*.go",
        callback = function()
          local get_diagnostic = vim.diagnostic.get()
          local unhandle_error = {}
          for _, v in pairs(get_diagnostic) do
            -- remove unused library
            local pattern = '^"(.-)" imported and not used$'
            if v.message:match(pattern) then
              vim.api.nvim_buf_set_lines(v.bufnr, v.lnum, v.end_lnum + 1, false, {})
            end

            table.insert(unhandle_error, v)

            -- if there's still diagnostic exist with severity FATAL, then show the popup
          end
          if #unhandle_error > 0 then
            toggle_telescope(unhandle_error)
          end
        end,
      })
    end,
  },
}
