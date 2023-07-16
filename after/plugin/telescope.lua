local telescope = require('telescope')
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

telescope.setup {
    defaults = {
        file_ignore_patterns = { '.git/', 'vendor/', 'node_modules/' },
        find_command = { 'rg', '--hidden', '--files' },
    },
    pickers = {
        find_files = {
            find_command = { 'rg', '--hidden', '--files' },
        },
    },
}
