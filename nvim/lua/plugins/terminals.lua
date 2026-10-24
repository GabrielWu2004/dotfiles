return {
	{
		"folke/snacks.nvim",
		opts = {
			terminal = {
				win = {
					position = "bottom",
					keys = {
						-- Snacks string mappings name actions; use callbacks to run commands.
						nav_h = {
							"<C-h>",
							function()
								vim.cmd.stopinsert()
								vim.cmd.TmuxNavigateLeft()
							end,
							desc = "Go Left",
							mode = "t",
						},
						nav_j = {
							"<C-j>",
							function()
								vim.cmd.stopinsert()
								vim.cmd.TmuxNavigateDown()
							end,
							desc = "Go Down",
							mode = "t",
						},
						nav_k = {
							"<C-k>",
							function()
								vim.cmd.stopinsert()
								vim.cmd.TmuxNavigateUp()
							end,
							desc = "Go Up",
							mode = "t",
						},
						nav_l = {
							"<C-l>",
							function()
								vim.cmd.stopinsert()
								vim.cmd.TmuxNavigateRight()
							end,
							desc = "Go Right",
							mode = "t",
						},
						hide_slash = {
							"<C-/>",
							function()
								require("config.terminals").toggle()
							end,
							desc = "Toggle Terminal",
							mode = "t",
						},
						hide_underscore = {
							"<C-_>",
							function()
								require("config.terminals").toggle()
							end,
							desc = "which_key_ignore",
							mode = "t",
						},
					},
				},
			},
		},
	},
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{ "<leader>t", group = "terminals", icon = "" },
			},
		},
	},
}
