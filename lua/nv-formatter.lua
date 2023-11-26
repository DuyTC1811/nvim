local status, conform = pcall(require, 'conform')
if (not status) then vim.notify('conform: is not installed! ', vim.log.levels.WARN) return end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang-format -i --style=Google" },
    cpp = { "clang-format -i --style=Google" },
  },
  vim.keymap.set({'n', 'v'}, '<leader>mp', function ()
    conform.format({
      ls_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
  end, { desc = 'Format file or range (in visual mode)'}),

  notify_on_error = true,
})

