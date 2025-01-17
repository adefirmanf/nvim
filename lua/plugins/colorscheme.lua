-- return { { "catppuccin/nvim", name = "catppuccin", priority = 1000 } }
-- return {
--   "scottmckendry/cyberdream.nvim",
--   lazy = false,
--   priority = 1000,
-- }
return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "warmer",
    })
  end,
}
