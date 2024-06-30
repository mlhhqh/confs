-- File: minimal_extension.lua

-- Utility function to create rounded borders
local function rounded_border()
  return {
    { '╭', 'FloatBorder' }, { '─', 'FloatBorder' }, { '╮', 'FloatBorder' },
    { '│', 'FloatBorder' }, { '╯', 'FloatBorder' }, { '─', 'FloatBorder' },
    { '╰', 'FloatBorder' }, { '│', 'FloatBorder' }
  }
end

-- Initialize data for the windows
local left_items = { "Item 1", "Item 2", "Item 3", "Item 4" }
local right_contents = {
  "Content for Item 1",
  "Content for Item 2",
  "Content for Item 3",
  "Content for Item 4"
}

-- Function to create a floating window
local function create_floating_window(opts)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = opts.width,
    height = opts.height,
    col = (vim.o.columns - opts.width) / 2 + opts.col_offset,
    row = (vim.o.lines - opts.height) / 2 + opts.row_offset,
    style = 'minimal',
    border = rounded_border()
  })

  vim.api.nvim_win_set_option(win, 'cursorline', true)

  return buf, win
end

-- Create the floating windows
local left_buf, left_win = create_floating_window({ width = 30, height = 10, col_offset = -20, row_offset = 0 })
local right_buf, right_win = create_floating_window({ width = 20, height = 10, col_offset = 20, row_offset = 0 })

-- Populate the left window with the list items
vim.api.nvim_buf_set_option(left_buf, 'modifiable', true)
vim.api.nvim_buf_set_lines(left_buf, 0, -1, false, left_items)
vim.api.nvim_buf_set_option(left_buf, 'modifiable', false)

-- Function to update the right window content based on the left window selection
local function update_right_window(index)
  vim.api.nvim_buf_set_option(right_buf, 'modifiable', true)
  vim.api.nvim_buf_set_lines(right_buf, 0, -1, false, { right_contents[index] })
  vim.api.nvim_buf_set_option(right_buf, 'modifiable', false)
end

-- Initial content for the right window
update_right_window(1)

-- Set up autocommands to handle cursor movement in the left window
vim.api.nvim_create_autocmd("CursorMoved", {
  buffer = left_buf,
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(left_win)
    local line = cursor[1]
    update_right_window(line)
  end
})

-- Set the key mappings to cycle through the list in the left window
vim.api.nvim_buf_set_keymap(left_buf, 'n', '<Up>', 'k', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(left_buf, 'n', '<Down>', 'j', { noremap = true, silent = true })

