local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if (not status) then vim.notify('nvim-treesitter: is not installed! ', vim.log.levels.WARN) return end

treesitter.setup {
  ensure_installed = { 'c', 'lua', 'rust', 'vimdoc' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
