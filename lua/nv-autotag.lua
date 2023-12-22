local status, autotag = pcall(require, "nvim-ts-autotag")
if not status then
    return
end
if not status then
    vim.notify("nvim-ts-autotag: is not installed! ", vim.log.levels.WARN)
    return
end
autotag.setup({})
