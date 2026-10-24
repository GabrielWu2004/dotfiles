return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		init = function()
			-- Define only the four directional keys; leave Ctrl-\\ available to terminals.
			vim.g.tmux_navigator_no_mappings = 1
		end,
		keys = {
			{ "<C-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" }, desc = "Go Left (Neovim/tmux)" },
			{ "<C-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" }, desc = "Go Down (Neovim/tmux)" },
			{ "<C-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" }, desc = "Go Up (Neovim/tmux)" },
			{ "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" }, desc = "Go Right (Neovim/tmux)" },
		},
	},
}
