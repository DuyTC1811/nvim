local status, notifier = pcall(require, "notifier")
if not status then
    return
end
if not status then
    vim.notify("notifier: is not installed! ", vim.log.levels.WARN)
    return
end
notifier.setup({})
