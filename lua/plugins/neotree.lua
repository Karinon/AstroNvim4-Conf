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

        -- This hack tackles it via an callback which goes to the top via gg
        set_root = function(state)
          local fs = require "neo-tree.sources.filesystem"
          local tree = state.tree
          local node = tree:get_node()
          if node.type == "file" then
            if state.search_pattern then fs.reset_search(state, false) end
            local g = function() vim.cmd.normal "gg" end
            fs._navigate_internal(state, node:get_parent_id(), nil, g, false)
          elseif node.type == "directory" then
            if state.search_pattern then fs.reset_search(state, false) end
            local g = function() vim.cmd.normal "gg" end
            fs._navigate_internal(state, node.id, nil, g, false)
          end
        end,
      },
      -- window = {
      --   mappings = {
      --     ["M"] = "derp",
      --   },
      -- },
    },
    source_selector = {
      winbar = false,
    },
  },
}
