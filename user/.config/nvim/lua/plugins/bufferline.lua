return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup({
            options = {
                style_preset = require('bufferline').style_preset.default,
                indicator = {style = 'none'},
                show_buffer_close_icons = false,
                separator_style = 'slant',
                offsets = {{
                    filetype = 'neo-tree',
                    text = 'NeoTree',
                    separator = ' ',
                }},
            },
        })
    end

}
