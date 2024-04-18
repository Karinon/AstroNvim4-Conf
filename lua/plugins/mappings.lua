return {
	{
		"AstroNvim/astrocore",
		opts = {
			mappings = {
				-- first key is the mode
				n = {
					["gb"] = false,
					["gB"] = false,
					["gb"] = {
            ":bNext<cr>",
						--function()
						--	require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
						--end,
						desc = "Next buffer",
					},
					["gB"] = {
            ":bprevious<cr>",
						--function()
						--	require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
						--end,
						desc = "Previous buffer",
					},

					["<C-q>"] = false,
					["<Leader>b"] = { name = "Buffers" },
					["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
					["<C-z>"] = { ":u<cr>", desc = "Undo" },
					["<leader>r"] = { ":%s/", desc = "Begin search/replace" },
					["<leader>a"] = { "ggVG", desc = "Select All" },
					["<leader><leader>rc"] = { ":AstroReload<cr>", desc = "Reloads config" },
					["<C-Left>"] = { "b", desc = "jump one word back" },
					["<C-Right>"] = { "e", desc = "jump one word forward" },
					["<C-V>"] = { '"+gP', desc = "paste from OS clipboard" },
					-- quick save
					-- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
				},
				i = {

					["<C-V>"] = { '<ESC>"+pA', desc = "paste from OS clipboard" },
					["<C-s>"] = { "<ESC>:w!<cr>", desc = "Save File" }, -- change description but the same command
				},
				v = {
					["<C-C>"] = { '"+y', desc = "copy to OS clipboard" },
					-- ["<leader>st"] = { ":ToggleTermSendVisualLines<CR>", desc = "Send selection to terminal" },
					["<leader>r"] = { ":s/", desc = "Begin search/replace" },
				},
				t = {
					-- setting a mapping to false will disable it
					-- ["<esc>"] = false,
				},
			},
		},
	},
}
