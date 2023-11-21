vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 350)
require('nvim-autopairs').setup({})

local lspkind = require('lspkind')
local status, cmp = pcall(require, 'cmp')
if (not status) then return end

cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)                            -- For `luasnip` users.
        end,
    },
    mapping = {
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm { select = false }
    },
    -- Installed sources:
    sources = {
        { name = 'path' },                                                      -- file paths
        { name = 'nvim_lsp', keyword_length = 1, priority = 10 },               -- from language server
        { name = 'crates', keyword_length = 1, priority = 10 },
        { name = 'luasnip', keyword_length = 1, priority = 7 },                 -- for lua users
        { name = 'nvim_lsp_signature_help', priority = 8 },                     -- display function signatures with current parameter emphasized
        { name = 'nvim_lua', keyword_length = 1, priority = 8 },                -- complete neovim's Lua runtime API such vim.lsp.*
        { name = 'buffer', keyword_length = 1, priority = 5 },                  -- source current buffer
        { name = 'calc' },                                                      -- source for math calculation
    },
    window = {
      completion = cmp.config.window.bordered({
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
      }),
      documentation = cmp.config.window.bordered({
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
      }),
    },
    formatting = {
--         fields = { 'menu', 'abbr', 'kind' },
        format = lspkind.cmp_format({
            mode = 'symbol_text',                                               -- show only symbol annotations
            maxwidth = 60,                                                      -- prevent the popup from showing more than provided characters
            -- The function below will be called before any actual modifications from lspkind:
            before = function(entry, vim_item)
                local menu_icon = {
                    nvim_lsp = '[Lsp]',
                    luasnip = '[Luasnip]',
                    buffer = '[Buffer]',
                    path = '[Path]',
                }
                vim_item.menu = menu_icon[entry.source.name]
                return vim_item
            end,
        })

    },
    preselect = cmp.PreselectMode.None,
    diagnostics = {
    enable = true,  -- Bật chẩn đoán
    icons = {
      hint = '󰌶 ',
      information = ' ',
      warning = ' ',
      error = ' ',
    },
  },
})

-- `/` cmdline setup.
cmp.setup.cmdline({'/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
