local function toggle_telescope(harpoon_files)
  local finder = function()
    local paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(paths, item.value)
    end

    return require("telescope.finders").new_table({
      results = paths,
    })
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = finder(),
      previewer = require("telescope.config").values.file_previewer({}),
      sorter = require("telescope.config").values.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<C-d>", function()
          local state = require("telescope.actions.state")
          local selected_entry = state.get_selected_entry()
          local current_picker = state.get_current_picker(prompt_bufnr)

          table.remove(harpoon_files.items, selected_entry.index)
          current_picker:refresh(finder())
        end)
        return true
      end,
    })
    :find()
end

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local h = require("harpoon").setup({})
      local wk = require("which-key")

      -- Add file to harpoon
      wk.add({
        {
          "<leader>a",
          function()
            h:list():add()
          end,
          desc = "Add File to Harpoon",
        },
      })
      -- Toggle Harpoon UI
      wk.add({
        {
          "<C-e>",
          function()
            toggle_telescope(h:list())
          end,
          desc = "Toggle Harpoon UI",
        },
      })

      wk.add({
        {
          "<C-s>",
          function()
            h:list():next()
          end,
          desc = "Next to file in harpoon list",
        },
      })

      wk.add({
        {
          "<C-a>",
          function()
            h:list():prev()
          end,
          desc = "Prev to file in harpoon list",
        },
      })
    end,
  },
}
