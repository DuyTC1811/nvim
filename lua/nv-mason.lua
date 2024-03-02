local status, mason = pcall(require, "mason")
if not status then
    vim.notify("mason: is not installed! ", vim.log.levels.WARN)
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "lua_ls",
    },
    automatic_installation = true,
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "clang-format", -- clang-format
    },
})
