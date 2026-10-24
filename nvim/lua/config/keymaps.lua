-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local terminals = require("config.terminals")
local map = vim.keymap.set

map("n", "<leader>tn", terminals.new, { desc = "New Terminal" })
map("n", "<leader>tt", terminals.select, { desc = "Select Terminal" })
map("n", "<leader>t]", function()
	terminals.cycle(1)
end, { desc = "Next Terminal" })
map("n", "<leader>t[", function()
	terminals.cycle(-1)
end, { desc = "Previous Terminal" })
map("n", "<leader>ft", function()
	terminals.open(vim.v.count1)
end, { desc = "Terminal (Root Dir)" })
map({ "n", "t" }, "<C-/>", terminals.toggle, { desc = "Toggle Terminal" })
map({ "n", "t" }, "<C-_>", terminals.toggle, { desc = "which_key_ignore" })
