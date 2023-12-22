local statusDap, dap = pcall(require, "dap")
if not statusDap then
    vim.notify("dap: is not installed! ", vim.log.levels.WARN)
    return
end

local statusDapui, dapui = pcall(require, "dapui")
if not statusDapui then
    vim.notify("dapui: is not installed! ", vim.log.levels.WARN)
    return
end

local statusVirtual, dapui_virtual = pcall(require, "nvim-dap-virtual-text")
if not statusVirtual then
    vim.notify("nvim-dap-virtual-text: is not installed! ", vim.log.levels.WARN)
    return
end

-- Define paths to the 'codelldb' extension and 'liblldb' library
local data_dir = vim.fn.stdpath("data")
local codelldb_path = data_dir .. "/mason/packages/codelldb/extension/adapter/codelldb"
local liblldb_path

-- Set the 'liblldb' path based on the OS (Mac or non-Mac)
if vim.fn.has("mac") == 1 then
    liblldb_path = data_dir .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
else
    liblldb_path = data_dir .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
end

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
    },
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

dapui.setup()
dapui_virtual.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<F12>", require("dap").step_out)
vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
