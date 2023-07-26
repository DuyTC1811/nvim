local status, rust_tool= pcall(require, 'rust-tools')
if (not status) then return end

local path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/") or ""
local codelldb_path = path .. "adapter/codelldb"
local liblldb_path = path .. "lldb/lib/liblldb.dylib"

if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then

rust_tool.setup({
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    server = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<Leader>k", rust_tool.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>a", rust_tool.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
    tools = {
        hover_actions = {
            auto_focus = true,
        },
    },
})

else
  local msg = 'Either codelldb or liblldb is not readable !'
  vim.notify(msg, vim.log.levels.ERROR)
end
