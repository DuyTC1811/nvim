return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.opt.termguicolors = true

        -- Định nghĩa opts để tránh lỗi
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_set_keymap

        -- Cấu hình bufferline
        require("bufferline").setup({
            options = {
                mode = "buffers",
                diagnostics = "nvim_lsp",
                separator_style = "slant",
            },
        })

        -- Di chuyển giữa các buffer
        keymap("n", "<S-l>", ":bnext<CR>", opts)
        keymap("n", "<S-h>", ":bprevious<CR>", opts)
    end,
}
