vim.g.mapleader = " "
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    "kyazdani42/nvim-tree.lua",

    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp-signature-help",

    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    "kdheepak/lazygit.nvim",
    "lewis6991/gitsigns.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "windwp/nvim-autopairs", event = "InsertEnter" },
    "projekt0n/github-nvim-theme",
    "nvim-lualine/lualine.nvim",
    { "akinsho/bufferline.nvim", version = "*" },
    { "akinsho/toggleterm.nvim", version = "*", config = true },
    "nvim-tree/nvim-web-devicons",
    "karb94/neoscroll.nvim",
    "rcarriga/nvim-notify",
    "vigoux/notifier.nvim",
    { "glepnir/dashboard-nvim", event = "VimEnter" },
    "Pocco81/auto-save.nvim",
    "Civitasv/cmake-tools.nvim",
    "stevearc/conform.nvim",
})
