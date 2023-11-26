vim.opt.termguicolors = true

vim.notify = require('notify')
local status, notifys = pcall(require, 'notify')
if (not status) then vim.notify('notify: is not installed! ', vim.log.levels.WARN) return end

notifys.setup({
  stages = 'slide',
  on_open = nil,
  on_close = nil,
  render = 'default', timeout = 3000,
  background_colour = 'Normal',
  minimum_width = 50,
  icons = {
    ERROR = ' ',
    WARN = ' ',
    INFO = ' ',
    DEBUG = ' ',
    TRACE = ' ',
  },
})
