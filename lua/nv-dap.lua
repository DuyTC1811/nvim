local statusDap, dap = pcall(require, "dap")
if not statusDap then
    vim.notify("dap: is not installed!", vim.log.levels.WARN)
    return
end

local statusDapui, dapui = pcall(require, "dapui")
if not statusDapui then
    vim.notify("dapui: is not installed!", vim.log.levels.WARN)
    return
end

local statusVirtual, dapui_virtual = pcall(require, "nvim-dap-virtual-text")
if not statusVirtual then
    vim.notify("nvim-dap-virtual-text: is not installed!", vim.log.levels.WARN)
    return
end

local statusDapgo, dapgo = pcall(require, "dap-go")
if not statusDapgo then
  vim.notify("dapgo: is not installed!", vim.log.levels.WARN)
  return
end

-- DAP UI setup
dapui.setup()
			require("dapui").setup()
			require("dap-go").setup()
dapui_virtual.setup()

dapgo.setup({
  dap_configurations = {
    {
      type = "go",
      name = "Debug (Build Flags)",
      request = "launch",
      program = "${file}",
      buildFlags = dapgo.get_build_flags,
    },
    {
      type = "go",
      name = "Debug (Build Flags & Arguments)",
      request = "launch",
      program = "${file}",
      args = dapgo.get_arguments,
      buildFlags = dapgo.get_build_flags,
    },
    {
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  }
})

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- Key mappings
vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
vim.keymap.set("n", "<leader>b", function() require("dap").toggle_breakpoint() end)
vim.keymap.set("n", "<leader>td", function() require("dap-go").debug_test() end)
vim.keymap.set("n", "<leader>tl", function() require("dap-go").debug_last_test() end)

