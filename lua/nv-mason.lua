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
        "neocmake",
    },
    automatic_installation = true,
})

