require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.6,
        width = 0.6,
        x = 0.5, -- X axis of the terminal window
        y = 0.5, -- Y axis of the terminal window
    },
})

-- Example keybindings
vim.keymap.set('n', '<Leader>t', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
