local status, fidget = pcall(require, "fidget")
if not status then
    vim.notify("fidget: is not installed! ", vim.log.levels.WARN)
    return
end

fidget.setup({
    dots = true,
})
