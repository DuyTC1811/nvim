local status, toggleterm = pcall(require, 'toggleterm')
if (not status) then return end
local Terminal  = require('toggleterm.terminal').Terminal
toggleterm.setup({})

local opt = { noremap = true, silent = true }
local opts = { buffer = 0}

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

local lazygit = Terminal:new({
  cmd = 'lazygit',
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
  on_open = function(term)
    vim.cmd('startinsert!')
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', opt )
  end,
  on_close = function()
    vim.cmd('startinsert!')
  end,
})

function lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap('n', '<Leader>g', '<cmd>lua lazygit_toggle()<CR>', opt)
vim.api.nvim_set_keymap('n', '<Leader>t', '<cmd>ToggleTerm<CR>', opt)
vim.api.nvim_set_keymap('t', '<C-\\><C-n>', '<Esc>', opt)
