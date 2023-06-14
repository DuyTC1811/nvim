vim.loader.enable()

local conf_files = {
  'nv-options',
  'nv-keymaps',
  'nv-plugins',
  'nv-lsp',
  'nv-dap',
  'nv-rust',
  'nv-tree',
  'nv-fidget',
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
}

for _, name in ipairs(conf_files) do
  require(name)
end
