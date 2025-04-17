return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Disable netrw (must be at top level)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- Enable true color
    vim.opt.termguicolors = true
    -- Setup nvim-tree
    require("nvim-tree").setup({})
    -- Set keymaps
    local opt = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opt)
    vim.api.nvim_set_keymap("n", "<Leader>fc", ":NvimTreeFindFile<CR>", opt)
    vim.api.nvim_set_keymap("n", "<Leader>fr", ":NvimTreeRefresh<CR>", opt)
  end,
}
