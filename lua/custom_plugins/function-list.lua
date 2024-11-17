local M = {}

local function toggle_telescope(function_lists, _)
  local opts = {
    prompt_title = "Method List",
    sorting_strategy = "ascending", -- Controls sorting and position of prompt
    layout_config = {
      preview_cutoff = 2,
      height = 0.8, -- Adjust height if needed
      prompt_position = "bottom", -- Positions prompt at top
    },
    previewer = true,
  }

  local results = {}
  for _, v in pairs(function_lists) do
    local entry = {
      display_text = v.function_name,
      ordinal = v.function_name,
      line = v.start_line,
      col = v.start_col,
      buffer = v.bufnr,
      path = v.file_path,
    }
    table.insert(results, entry)
  end

  print("Total Results", #results)

  vim.defer_fn(function()
    require("telescope.pickers")
      .new(opts, {
        prompt_title = "Method List",
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

function M.function_list()
  local ts = vim.treesitter
  local buffer = vim.api.nvim_get_current_buf()

  -- Parse the query for function declarations in Go
  local query = ts.query.parse(
    "go",
    [[
    (function_declaration
      name: (identifier) @function_name
    )
    (method_declaration
      name: (field_identifier) @method_name
    )
  ]]
  )

  -- Get the parser for the current buffer with "go" language
  local parser = ts.get_parser(buffer, "go")
  local tree = parser:parse()[1] -- Get the syntax tree

  local results = {}
  -- Iterate through the matches in the query
  for _, match, _ in query:iter_matches(tree:root(), buffer) do
    for _, node in pairs(match) do
      local function_name = vim.treesitter.get_node_text(node, buffer)

      -- Get the starting and ending positions (line and column) of the node
      local start_line, start_col, _ = node:start()

      local result = {
        bufnr = buffer,
        file_path = vim.api.nvim_buf_get_name(buffer),
        function_name = function_name,
        start_line = start_line,
        start_col = start_col,
      }
      table.insert(results, result)
    end
  end
  toggle_telescope(results, {})
end

function M.setup(opts)
  -- Merge user options with defaults
  opts = opts or {}

  -- Create the user command
  vim.api.nvim_create_user_command("FunctionList", M.function_list, {})

  -- List function --
  vim.keymap.set("n", "<C-f>", M.function_list, {
    desc = "Hello world",
    silent = true,
  })
end

return M
