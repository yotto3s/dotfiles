return {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local wilder = require('wilder')
        wilder.setup({modes = {':'}})

        wilder.set_option('pipeline', {
          wilder.branch(
            wilder.cmdline_pipeline(),
            wilder.search_pipeline()
          ),
        })

        local popupmenu_renderer = wilder.popupmenu_renderer({
          border = "rounded",
          highlighter = wilder.basic_highlighter(),
          left = {' ', wilder.popupmenu_devicons()},
          right = {' ', wilder.popupmenu_scrollbar()},
        })

        local wildmenu_renderer = wilder.wildmenu_renderer({
          highlighter = wilder.basic_highlighter(),
          left = {' ', wilder.popupmenu_devicons()},
          right = {' ', wilder.popupmenu_scrollbar()},
        })

        wilder.set_option('renderer', wilder.renderer_mux({
            [":"] = popupmenu_renderer,
            ["/"] = wildmenu_renderer,
            ["?"] = wildmenu_renderer,
        }))
    end
}
