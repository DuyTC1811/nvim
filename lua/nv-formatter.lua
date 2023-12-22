local status, conform = pcall(require, "conform")
if not status then
    vim.notify("conform: is not installed! ", vim.log.levels.WARN)
    return
end

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
    },
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
        conform.format({
            ls_fallback = true,
            async = false,
            timeout_ms = 500,
        })
    end, { desc = "Format file or range (in visual mode)" }),

    notify_on_error = true,
})
