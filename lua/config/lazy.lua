-- This is an entrypoint for the lazy
-- DO NOT ADD / EDIT SOMETHING THAT'S NOT RELATED ON NVIM / LAZYVIM
-- Everything that related with Plugins must be under plugins folder
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup("plugins")

-- Setup theme from the plugins
vim.cmd.colorscheme("onedark")

-- Setup tabwidth while editing
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Show the line number
vim.wo.relativenumber = true

-- Force to use clipboard. So, copy-paste can shared
-- between terminal
-- clipboard for Mac OS
vim.opt.clipboard:append({ "unnamedplus" })
