local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
  vim.notify("[ DAP ] Plugin 'dap' not found!", vim.log.levels.WARN)
  return
end

local ok_dapui, dapui = pcall(require, "dapui")
if not ok_dapui then
  vim.notify("[ DAP ] Plugin 'dapui' not found!", vim.log.levels.WARN)
  return
end

local ok_virtual, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not ok_virtual then
  vim.notify("[ DAP ] Plugin 'nvim-dap-virtual-text' not found!", vim.log.levels.WARN)
  return
end

local ok_dapgo, dapgo = pcall(require, "dap-go")
if not ok_dapgo then
  vim.notify("[ DAP ] Plugin 'dap-go' not found!", vim.log.levels.WARN)
  return
end

-- Cấu hình Delve adapter
dap.adapters.delve = function(callback, config)
  if config.mode == "remote" and config.request == "attach" then
    callback({
      type = "server",
      host = config.host or "127.0.0.1",
      port = config.port or "38697",
    })
  else
    callback({
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
        detached = vim.fn.has("win32") == 0,
      },
    })
  end
end

-- Cấu hình DAP cho Go
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

-- Cấu hình dap-go thêm tuỳ chọn nâng cao
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
  },
})

-- Khởi tạo UI
dapui.setup()
dap_virtual_text.setup()

-- Tự động mở/đóng dapui khi debugging
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- Keymaps tiện lợi
vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Start/Continue Debugging" })
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>td", function() dapgo.debug_test() end, { desc = "Debug Go Test" })
vim.keymap.set("n", "<leader>tl", function() dapgo.debug_last_test() end, { desc = "Debug Last Go Test" })
