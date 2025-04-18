-------------------------------------
----------[ GENARAL SETING ]---------
-------------------------------------
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

---------[ TURN OF HIGHLIGHT ]-------
keymap("n", "<ESC>", ":nohlsearch<CR>", opts)

-------------------------------------
-----[ MOVE BETWEEN WINDOWS ]--------
-------------------------------------
keymap("n", "<C-h>", "<C-w>h", opts) -- sang trái
keymap("n", "<C-j>", "<C-w>j", opts) -- xuống
keymap("n", "<C-k>", "<C-w>k", opts) -- lên
keymap("n", "<C-l>", "<C-w>l", opts) -- sang phải

-------------------------------------
--------[ RESIZE WINDOWS]------------
-------------------------------------
keymap("n", "<C-Up>", ":resize -2<CR>", opts) -- nhỏ chiều dọc
keymap("n", "<C-Down>", ":resize +2<CR>", opts) -- to chiều dọc
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts) -- nhỏ ngang
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts) -- to ngang

-------------------------------------
---------[ MOVE CURRENT LINE ]-------
-------------------------------------
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts) -- move down
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts) -- move up

keymap("i", "jk", "<ESC>", opts) -- exit insert

-------------------------------------
-----[ KEEP SELECTION INTACT ]-------
-------------------------------------
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-------------------------------------
-----[ MOVE SELECT PARAGRAPH ]-------
-------------------------------------
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-------------------------------------
-----[ MOVE BLOCK UP/DOWN ]-------
-------------------------------------
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-------------------------------------
-----[ MOVE WINDOWS IN TERMINAL ]----
-------------------------------------
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-------------------------------------
---[ NAVIGATE POUP AUTOCOMPLETE ]----
-------------------------------------
keymap("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
keymap("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })
