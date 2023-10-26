local status, notifier = pcall(require, 'notifier')
if (not status) then return end

notifier.setup({})
