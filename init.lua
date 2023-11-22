local conf_files = {
  'nv-options',
  'nv-keymaps',
  'nv-plugins',
  'nv-lsp',
  'nv-dap',
  'nv-rust',
  'nv-tree',
  'nv-notifier',
  'nv-togglerm',
  'nv-mason',
  'nv-lazygit',
  'nv-colorscheme',
  'nv-treesitter',
  'nv-notify',
  'nv-gitsigns',
  'nv-lualine',
  'nv-bufferline',
  'nv-neoscroll',
  'nv-telescope',
  'nv-completion',
  'nv-dashboard',
  'nv-autosave',
  'nv-autotag',
  'nv-formatter',
  'nv-cmake'
}

for _, name in ipairs(conf_files) do
  require(name)
end

vim.loader.enable()
