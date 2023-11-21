-- Check if the 'rust-tools' plugin is available
local status, rust_tool = pcall(require, 'rust-tools')
if not status then
    return
end

-- Define paths to the 'codelldb' extension and 'liblldb' library
local data_dir = vim.fn.stdpath("data")
local codelldb_path = data_dir .. "/mason/packages/codelldb/extension/adapter/codelldb"
local liblldb_path

-- Set the 'liblldb' path based on the OS (Mac or non-Mac)
if vim.fn.has('mac') == 1 then
    liblldb_path = data_dir .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
else
    liblldb_path = data_dir .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
end

-- Check if both 'codelldb' and 'liblldb' are readable files
if not (vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path)) then
    local msg = 'Either codelldb or liblldb is not readable!'
    vim.notify(msg, vim.log.levels.ERROR)
    return end

-- Configure 'rust-tools'
rust_tool.setup({
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    server = {
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

