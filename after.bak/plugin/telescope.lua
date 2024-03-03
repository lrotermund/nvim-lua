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
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "-l",
        },
    },
    pickers = {
        find_files = {
            find_command = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--files",
                "-l",
            },
        },
    },
}
