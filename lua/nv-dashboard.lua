local status , dashboard = pcall(require, 'dashboard')
if (not status) then return end

dashboard.setup({
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Apps',
        group = 'DiagnosticHint',
        action = 'Telescope app',
        key = 'a',
      },
      {
        desc = ' Dotfiles',
        group = 'number',
        action = 'Telescope dotfiles',
        key = 'd',
      },
      {
        desc = 'Quit Nvim',
        group = 'number',
        action = 'q',
        key = 'q',
      },

    },
  },
})

