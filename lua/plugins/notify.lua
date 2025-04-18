return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        vim.notify = notify

        notify.setup({
            stages = "fade_in_slide_out",
            render = "default",
            timeout = 3000,
            background_colour = "Normal",
            minimum_width = 50,
            icons = {
                ERROR = " ",
                WARN = " ",
                INFO = " ",
                DEBUG = " ",
                TRACE = " ",
            },
        })
    end,
}
