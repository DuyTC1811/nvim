vim.opt.termguicolors = true
local status, bufferline = pcall(require, 'bufferline')
if (not status) then vim.notify('bufferline: is not installed! ', vim.log.levels.WARN) return end
bufferline.setup({})
