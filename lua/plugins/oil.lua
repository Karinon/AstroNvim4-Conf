return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "SirZenith/oil-vcs-status",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("oil").setup {
        -- your oil.nvim setup
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        view_options = {
          show_hidden = true,
        },
        default_file_explorer = true,
        win_options = {
          signcolumn = "yes:2",
        },
      }
      local status_const = require "oil-vcs-status.constant.status"
      local StatusType = status_const.StatusType
      require("oil-vcs-status").setup {
        -- your oil-vcs-status setup
        status_symbol = {
          [StatusType.Added] = "",
          [StatusType.Copied] = "󰆏",
          [StatusType.Deleted] = "",
          [StatusType.Ignored] = "",
          [StatusType.Modified] = "",
          [StatusType.Renamed] = "",
          [StatusType.TypeChanged] = "󰉺",
          [StatusType.Unmodified] = " ",
          [StatusType.Unmerged] = "",
          [StatusType.Untracked] = "",
          [StatusType.External] = "",

          [StatusType.UpstreamAdded] = "󰈞",
          [StatusType.UpstreamCopied] = "󰈢",
          [StatusType.UpstreamDeleted] = "",
          [StatusType.UpstreamIgnored] = " ",
          [StatusType.UpstreamModified] = "󰏫",
          [StatusType.UpstreamRenamed] = "",
          [StatusType.UpstreamTypeChanged] = "󱧶",
          [StatusType.UpstreamUnmodified] = " ",
          [StatusType.UpstreamUnmerged] = "",
          [StatusType.UpstreamUntracked] = " ",
          [StatusType.UpstreamExternal] = "",
        },
      }
    end,
  },
}
