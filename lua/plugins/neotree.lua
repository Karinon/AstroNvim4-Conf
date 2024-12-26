local my_set_root = function(state)
  local fs = require "neo-tree.sources.filesystem"
  local tree = state.tree
  local node = tree:get_node()
  if node.type == "file" then
    if state.search_pattern then fs.reset_search(state, false) end
    local g = function()
      vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- {line, column}
    end
    fs._navigate_internal(state, node:get_parent_id(), nil, g, false)
  elseif node.type == "directory" then
    if state.search_pattern then fs.reset_search(state, false) end
    local g = function()
      vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- {line, column}
    end
    fs._navigate_internal(state, node.id, nil, g, false)
  end
end

local my_fuzzy_finder = function(state)
  my_set_root(state)
  local commands = require "neo-tree.sources.filesystem.commands"
  commands.fuzzy_finder(state)
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  opts = {
    -- event_handlers = {
    --   {
    --     event = "fs_event",
    --     handler = function(file_path)
    --       -- auto close
    --       vimc.cmd("Neotree close")
    --       require("neo-tree.command").execute({ action = "close" })
    --     end,
    --   },
    -- },
    --window = { position = "right", width = 100 },
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          "node_modules",
          -- '.git',
          -- '.DS_Store',
          -- 'thumbs.db',
        },
        never_show = {},
      },
      commands = {
        -- I got annoyed that neotree was not able to set a directory to root
        -- and scroll to the top. Instead it just showed the last file in the
        -- folder and I had to manually scroll up to see the rest of the files

        -- This hack tackles it via an callback which goes to the top
        set_root = my_set_root,
        fuzzy_finder = my_fuzzy_finder,
        show_fs_stat = function(state)
          local file_info = require "utils.file_info"
          local node = state.tree:get_node()
          local stat = vim.loop.fs_stat(node.path)
          local str = ""
          str = str .. string.format("Type: %s\n", stat.type)
          str = str .. string.format("Size: %s\n", file_info.format_size(stat.size))
          str = str .. string.format("Time: %s\n", file_info.format_time(stat.mtime.sec))
          str = str .. string.format("Mode: %s", file_info.format_mode(stat.mode, stat.type))
          vim.notify(str, "info", { title = node.name })
        end,
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ["ABSOLUTE PATH"] = filepath,
            ["FILENAME"] = filename,
            ["PATH (CWD)"] = modify(filepath, ":."),
            ["PATH (HOME)"] = modify(filepath, ":~"),
            ["URI"] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val) return vals[val] ~= "" end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            vim.notify("No values to copy", vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = "Choose to copy to clipboard:",
            format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
          }, function(choice)
            local result = vals[choice]
            if result then
              vim.notify(("Copied: `%s`"):format(result))
              vim.fn.setreg("+", result)
            end
          end)
        end,

        -- Inspired by @adoyle-h <3, for anyone who wants one keystroke approach like me, and got used with nvim-tree ways (note that I remapped c to "copy_to_clipboard" instead):
        copy_path = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          vim.fn.setreg("+", filepath)
          vim.notify("Path copied: " .. filepath)
        end,
      },
      window = {
        mappings = {
          ["i"] = "show_fs_stat",
          ["Y"] = { "copy_path", config = { title = "copy path" } },
        },
      },
    },
    source_selector = {
      winbar = false,
    },
  },
}
