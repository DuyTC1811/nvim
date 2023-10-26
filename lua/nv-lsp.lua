-- Setup language servers.
local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then return end

--------- C++ ----------------
lspconfig.clangd.setup({
    filetypes = { 'h', 'c', 'cpp', 'cuda', 'cc', 'objc', 'objcpp', 'proto'},
    cmd = {"clangd", "--background-index"},
    single_file_support = true,
    root_dir = lspconfig.util.root_pattern(
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac',
          '.git'
        )
})


--------- LSP Rust -----------
lspconfig.rust_analyzer.setup({
  assist = {
    importPrefix = "by_self",
  },
  cargo = {
    allFeatures = true,
  },
  checkOnSave = {
    command = "clippy",
  },
  lens = {
    references = true,
    methodReferences = true,
  },
})

------ LSP Lua --------
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

--------- LSP TS ---------
lspconfig.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = lspconfig.util.root_pattern ( "package.json", "tsconfig.json", "jsconfig.json", ".git" ),
  init_options = { hostInfo = "neovim" },
  single_file_support = true
}

-------- Helm Chart ------
lspconfig.helm_ls.setup({
  cmd = { "helm_ls", "serve" },
  filetypes = { "helm" },
  root_dir = lspconfig.util.root_pattern("Chart.yaml"),
  single_file_support = true
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     update_in_insert = false,
--     virtual_text = { spacing = 4, prefix = "●" },
--     severity_sort = true,
-- })
-- 
-- -- Diagnostic symbols in the sign column (gutter)
-- local signs = { Error = "Error", Warn = " ", Hint = "Hint", Info = " " }
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    source = "always", -- Or "if_many"
    focusable = false,
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
  },
})

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
