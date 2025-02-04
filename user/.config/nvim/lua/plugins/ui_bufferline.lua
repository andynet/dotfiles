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
        local close = function()
            local buf = vim.api.nvim_get_current_buf()
            vim.cmd('bprevious')
            vim.cmd(string.format('bdelete %d', buf))
        end

        vim.keymap.set('n', '<Leader>x', close           , {desc = 'Close buffer'})
        vim.keymap.set('n', '<Leader>k', ':bprevious<CR>', {desc = 'Previous buffer'})
        vim.keymap.set('n', '<Leader>l', ':bnext<CR>'    , {desc = 'Next buffer'})
    end
}
