return {
    'pappasam/nvim-repl',
    init = function()
        vim.g['repl_split'] = 'right'
        vim.g['repl_width'] = 52
        vim.g['repl_filetype_commands'] = {
            python = 'ipython --no-autoindent'
        }
    end,
    keys = {
        {'<leader>rt', '<CMD>ReplToggle<CR>' , mode = 'n', {desc = 'Toggle REPL'}},
        {'<leader>sc', '<CMD>ReplRunCell<CR>', mode = 'n', {desc = 'Send cell to REPL'}},
        {'<leader>sl', '<Plug>ReplSendLine'  , mode = 'n', {desc = 'Send line to REPL'}},
        {'<leader>ss', '<Plug>ReplSendVisual', mode = 'v', {desc = 'Send selection to REPL'}}
    },
}
