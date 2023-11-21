-- Setup language servers.
local status_lsp, lspconfig = pcall(require, 'lspconfig')
if (not status_lsp) then return end

local status_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_cmp then print('cmp_nvim_lsp is not installed') return end

 -- local status_mason_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')
 -- if (not status_mason_lspconfig) then return end
 -- 
 -- mason_lspconfig.setup({
 --   ensure_installed = {
 --     'clangd',
 --     'codelldb',
 --     'neocmakelsp',
 --   },
 --   automatic_installation = true,
 -- })


local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { buffer = bufnr, noremap = true, silent = true }

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
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>E', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

--------- C++ ----------------
lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
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

lspconfig.neocmake.setup({})

--------- LSP Rust -----------
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = { globals = {'vim'},
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
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
  cmd = {
    "typescript-language-server",
    "--stdio"
  },
  root_dir = lspconfig.util.root_pattern ( "package.json", "tsconfig.json", "jsconfig.json", ".git" ),
  init_options = { hostInfo = "neovim" },
  single_file_support = true
}

-------- Helm Chart ------
lspconfig.helm_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "helm_ls", "serve" },
  filetypes = { "helm" },
  root_dir = lspconfig.util.root_pattern("Chart.yaml"),
  single_file_support = true
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = ' ', Warn = ' ', Hint = '󰌶 ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '● ',
  }
})
