# 🔨 NVIM (Neo Vim)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white&style=for-the-badge)](https://conventionalcommits.org)
![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg?style=for-the-badge)

A custom Neovim config by the creator. Minimalist plugins with [Lazyvim](https://github.com/folke/lazy.nvim) package manager. 

# ⚡️ Started Plugins
This configuration has already been preinstalled with some plugins. 
* [LSP](https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#mason-lspconfignvim) - Nvim supports the Language Server Protocol (LSP), which means it acts as a client to LSP servers.
  * Error Linting
  * Code References
* [Formatter/Prettier](https://github.com/stevearc/conform.nvim?tab=readme-ov-file) - Files auto-formatting
* [Nvim-Tree/Navigation Tree](https://github.com/nvim-tree/nvim-tree.lua?tab=readme-ov-file) - Navigation Tree to easy navigate. By default set to `false`. Check the keymaps section to use the toggle.
* [Telescope/Search](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder list. You can search for something by using this. Currently, only search based on files, contents, buffer & documentation.
* [Treesitter/Code-Highlighting](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax Highlighting.
* [WhichKeys/Keymaps Helper](https://github.com/folke/which-key.nvim) - Keymaps Helper.

And many more...

# 🔥 Installation 
## Prerequisites
[Neovim](https://neovim.io/) >= v0.10
## Clone
```bash
git clone https://github.com/adefirmanf/nvim/ ${HOME}/.config/
```

# ⌨️ Basic Keymaps
These are the most frequent keymaps that I used. Custom keymaps are available on each plugin. Please refer to [`plugins`](https://github.com/adefirmanf/nvim/tree/main/lua/plugins) folder for more details. 
* Toggle Navigation Tree <kbd>\e</kbd>
* Find Files <kbd>\ff</kbd>
* Find Contents <kbd>\fg</kbd>
* Find Buffer <kbd>\fb</kbd>
* Find Buffer <kbd>\fb</kbd>
* Explore <kbd>\E</kbd>

# 🌃 Theme
By default, I use https://github.com/catppuccin/nvim. 

To install another theme, please check the docs on the official page. For this configuration, it should be set on [plugins](https://github.com/adefirmanf/nvim/blob/main/lua/plugins/colorscheme.lua) folder and [lazy.lua](https://github.com/adefirmanf/nvim/blob/946bae470f3d1ab7f5963beabb7c8b714c512a64/lua/config/lazy.lua#L31) config

# 📷 Screenshot
<details><summary>Starting up</summary>

  ![image](https://github.com/user-attachments/assets/a1743a5b-964a-4574-9d7a-ebef28986e0f)
  
</details>
<details><summary>Telescope/Search</summary>
  
  ![image](https://github.com/user-attachments/assets/45adfc14-5570-498c-9311-b075b613b068)
  
</details>
<details><summary>Nvim-Tree/Navigation Tree</summary>
  
  ![image](https://github.com/user-attachments/assets/255dd3b8-32c3-4578-bcc5-27097a06101a)

</details>

