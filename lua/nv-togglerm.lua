local status, toggleterm = pcall(require, "toggleterm")
if not status then
    vim.notify("toggleterm: is not installed! ", vim.log.levels.WARN)
    return
end
toggleterm.setup({})

local opt = { noremap = true, silent = true }
local opts = { buffer = 0 }

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

vim.api.nvim_set_keymap("n", "<Leader>t", "<cmd>ToggleTerm<CR>", opt)
