return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.move").setup() -- alt + hjkl
    require("mini.splitjoin").setup() -- gS
    require("mini.align").setup() -- ga + align-char
    require("mini.trailspace").setup()
  end,
}
