local statusDap, dap = pcall(require, 'dap')
if (not statusDap) then vim.notify('dap: is not installed! ', vim.log.levels.WARN) return end

local statusDapui, dapui = pcall(require, 'dapui')
if (not statusDapui) then vim.notify('dapui: is not installed! ', vim.log.levels.WARN) return end

local statusVirtual, dapui_virtual = pcall(require, 'nvim-dap-virtual-text')
if (not statusVirtual) then vim.notify('nvim-dap-virtual-text: is not installed! ', vim.log.levels.WARN) return end

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

vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
