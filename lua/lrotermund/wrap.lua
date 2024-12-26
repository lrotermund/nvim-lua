-- Funktion, die Text wrappt
local function wrap_text(lines, max_width)
  local wrapped = {}
  for _, line in ipairs(lines) do
    while #line > max_width do
      local wrap_point = line:sub(1, max_width + 1):match '^.*()%s' or max_width
      table.insert(wrapped, line:sub(1, wrap_point - 1))
      line = line:sub(wrap_point + 1)
    end
    table.insert(wrapped, line)
  end
  return wrapped
end

-- Hauptfunktion für den Text-Wrap
local function wrap_lines(mode)
  local max_width = 80
  local lines, start_row, end_row
  if mode == 'visual' then
    start_row, end_row = vim.fn.line "'<" - 1, vim.fn.line "'>" - 1
  elseif mode == 'current' then
    start_row, end_row = vim.fn.line '.' - 1, vim.fn.line '.' - 1
  else
    start_row, end_row = 0, vim.fn.line '$' - 1
  end

  lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
  local wrapped = wrap_text(lines, max_width)
  vim.api.nvim_buf_set_lines(0, start_row, end_row + 1, false, wrapped)
end

-- Neovim-Kommandos
vim.api.nvim_create_user_command('WrapLines', function(opts)
  if opts.range > 0 then
    wrap_lines 'visual'
  else
    wrap_lines(opts.args)
  end
end, { range = true, nargs = '?' })

-- Mapping: Auswahl (visual) oder aktuelle Zeile wrappen
vim.keymap.set('v', '<leader>ww', ':<C-U>WrapLines visual<CR>')
vim.keymap.set('n', '<leader>ww', ':WrapLines current<CR>')
vim.keymap.set('n', '<leader>wa', ':WrapLines<CR>')
