return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

        require("telescope").setup({
            defaults = {
                prompt_prefix = " ❯ ",
                initial_mode = "insert",
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "bottom",
                },
                file_ignore_patterns = {
                    "node_modules/",
                    ".git/",
                    ".DS_Store",
                },
                mappings = {
                    i = {
                        ["<ESC>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<TAB>"] = function(prompt_bufnr)
                            actions.toggle_selection(prompt_bufnr)
                            actions.move_selection_next(prompt_bufnr)
                        end,
                        ["<C-s>"] = actions.send_selected_to_qflist,
                        ["<C-q>"] = actions.send_to_qflist,
                    },
                },
            },
            pickers = {},
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case"
                },
            },
        })
    end,
}
