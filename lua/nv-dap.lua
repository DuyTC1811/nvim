local statusDap, dap = pcall(require, 'dap')
if (not statusDap) then return end

local statusDapui, dapui = pcall(require, 'dapui')
if (not statusDapui) then return end

local statusMasondap, mason_dap = pcall(require, 'mason-nvim-dap')
if (not statusMasondap) then return end

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

mason_dap.setup({
  ensure_installed = {'codelldb'},
  automatic_installation = false,
  handlers = nil,
})

vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
