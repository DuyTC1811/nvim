return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        -- Default options:
        require("gruvbox").setup({})
        vim.cmd("colorscheme gruvbox")
    end,
}
