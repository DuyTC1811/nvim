return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",

        "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
        local neogit = require("neogit")

        -- open using defaults (you might not need this unless for testing)
        -- neogit.open()

        -- Open neogit with options
        -- neogit.open({ "commit" }) -- to open commit popup
        -- neogit.open({ kind = "split" }) -- open in split
        -- neogit.open({ cwd = "~" }) -- open in different repo

        -- Setup (recommended)
        neogit.setup({})
    end,
    cmd = "Neogit", -- optional: lazy-load when :Neogit command is called
    keys = {
        { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" },
    },
}
