local M = {}
local active

local function terminals()
	local items = Snacks.terminal.list()
	table.sort(items, function(a, b)
		return a.buf < b.buf
	end)
	return items
end

local function current(items)
	for _, terminal in ipairs(items) do
		if terminal.buf == vim.api.nvim_get_current_buf() then
			return terminal
		end
	end
	for _, terminal in ipairs(items) do
		if terminal:valid() then
			return terminal
		end
	end
	for _, terminal in ipairs(items) do
		if terminal == active then
			return terminal
		end
	end
	return items[1]
end

local function hide_others(selected)
	for _, terminal in ipairs(terminals()) do
		if terminal ~= selected and terminal:valid() then
			terminal:hide()
		end
	end
end

local function show(terminal)
	if not terminal:buf_valid() then
		return
	end
	hide_others(terminal)
	active = terminal
	terminal:show():focus()
	vim.cmd.startinsert()
end

-- Keep the existing numbered Space f t workflow in the same terminal pane.
function M.open(count)
	hide_others()
	active = Snacks.terminal.get(nil, { cwd = LazyVim.root(), count = count or 1 })
	show(active)
end

function M.new()
	local count = 1
	for _, terminal in ipairs(terminals()) do
		local info = vim.b[terminal.buf].snacks_terminal or {}
		count = math.max(count, (info.id or 0) + 1)
	end
	M.open(count)
end

function M.toggle()
	local items = terminals()
	local selected = current(items)
	for _, terminal in ipairs(items) do
		if terminal:valid() then
			active = selected
			hide_others()
			return
		end
	end
	if selected then
		show(selected)
	else
		M.new()
	end
end

function M.cycle(direction)
	local items = terminals()
	if #items == 0 then
		return M.new()
	end
	local selected = current(items)
	local index = 1
	for i, terminal in ipairs(items) do
		if terminal == selected then
			index = i
			break
		end
	end
	show(items[((index - 1 + direction) % #items) + 1])
end

function M.select()
	local items = terminals()
	if #items == 0 then
		return M.new()
	end
	local selected = current(items)
	vim.cmd.stopinsert()
	Snacks.picker.select(items, {
		prompt = "Terminals",
		format_item = function(terminal)
			local info = vim.b[terminal.buf].snacks_terminal or {}
			local title = vim.b[terminal.buf].term_title or "shell"
			local cwd = vim.fn.fnamemodify(info.cwd or "", ":~")
			return string.format("%s%d: %s (%s)", terminal == selected and "* " or "  ", info.id or 1, title, cwd)
		end,
	}, function(terminal)
		if terminal then
			show(terminal)
		end
	end)
end

return M
