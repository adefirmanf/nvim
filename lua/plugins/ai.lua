return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    virtual_text = {
      enabled = true,
      key_bindings = {
        accept = "<S-Tab>"
      }
    },
  },
}
