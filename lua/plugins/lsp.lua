return {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    opts = {
        servers = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
            },
        },
    },
    config = function(_, opts)
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        for server, config in ipairs(opts.servers) do
            config.capabilities = vim.tbl_deep_extend("force", config.capabilities or {}, capabilities or {})

            vim.lsp.config(server, config)
            -- enable server
            vim.lsp.enable(server)
        end
    end,
}
