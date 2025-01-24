
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader><leader>f', require('telescope.builtin').find_files, { desc = 'search [F]iles' })
vim.keymap.set('n', '<leader><leader>h', require('telescope.builtin').help_tags, { desc = 'search [H]elp' })
vim.keymap.set('n', '<leader><leader>g', require('telescope').extensions.live_grep_args.live_grep_args, { desc = 'search by [G]ord' })
vim.keymap.set('n', '<leader><leader>w', require('telescope.builtin').grep_string, { desc = 'search [W]ord' })
vim.keymap.set('n', '<leader><leader>d', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader><leader>b', require('telescope.builtin').buffers, { desc = 'Find existing [B]uffers' })

-- toggleterm
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<C-\\>', '<Cmd>ToggleTerm direction=float<CR>', { desc = 'terminal: Toggle horizontal' })
vim.keymap.set('t', '<C-\\>', '<Cmd>ToggleTerm<CR>', { desc = 'terminal: Toggle horizontal' })

-- jaq (quickrun)
vim.keymap.set('n', '<F5>', '<Cmd>Jaq<CR>')

-- nvim-tree
vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>')

-- win resizer
vim.keymap.set('n', '<C-e>', '<Cmd>WinResizerStartResize<CR>')
