return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    -- Gọi setup để khởi tạo plugin
    require("toggleterm").setup()

    -- Keymap dùng để mở terminal từ Normal mode
    local opt = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "<Leader>t", "<cmd>ToggleTerm<CR>", opt)

    -- Tạo autocommand để map phím khi mở Terminal buffer
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end
    })
  end,
}
