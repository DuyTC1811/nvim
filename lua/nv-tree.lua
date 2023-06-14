-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local opt = { noremap = true, silent = true }

local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end

tree.setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- set up keyboard shortcuts for NvimTree
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', opt )
vim.api.nvim_set_keymap('n', '<Leader>fc', ':NvimTreeFindFile<CR>', opt )
vim.api.nvim_set_keymap('n', '<Leader>fr', ':NvimTreeRefresh<CR>', opt )

