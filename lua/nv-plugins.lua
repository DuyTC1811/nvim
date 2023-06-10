local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'kyazdani42/nvim-tree.lua'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        'nvim-telescope/telescope-media-files.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim', run = 'make'
    }
    use {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind.nvim',
        'hrsh7th/cmp-nvim-lsp-signature-help'
    }
    use {
        'mfussenegger/nvim-dap',
        'theHamsta/nvim-dap-virtual-text',
        'rcarriga/nvim-dap-ui',
        'simrat39/rust-tools.nvim'
    }
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    }
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'windwp/nvim-autopairs'
    use 'projekt0n/github-nvim-theme'                                           -- Theme
    use 'nvim-lualine/lualine.nvim'
    use {'akinsho/bufferline.nvim', tag = '*' }
    use 'numToStr/FTerm.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'karb94/neoscroll.nvim'
    use 'rcarriga/nvim-notify'
    use 'lewis6991/impatient.nvim'                                              -- Makes neovim faster
    use { 'j-hui/fidget.nvim', tag = 'legacy' }                                                     -- show status of nvim-lsp progress
    if packer_bootstrap then
        require('packer').sync()
    end
end)
