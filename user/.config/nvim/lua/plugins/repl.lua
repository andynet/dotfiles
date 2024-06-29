return {
    'pappasam/nvim-repl',
    init = function()
        vim.g['repl_split'] = 'right'
        vim.g['repl_width'] = 52
        vim.g['repl_filetype_commands'] = {
            python = 'ipython --no-autoindent'
            -- https://github.com/evcxr/evcxr
            -- rust = 'evcxr'
            -- https://github.com/evcxr/evcxr/blob/main/evcxr_jupyter/samples/evcxr_jupyter_tour.ipynb
            -- http://docs.spyder-ide.org/current/panes/ipythonconsole.html
        }
    end,
    keys = {
        {'<leader>rt', '<CMD>ReplToggle<CR>',  mode = 'n', {desc = 'Toggle REPL'}},
        {'<leader>rc', '<CMD>ReplClear<CR>',   mode = 'n', {desc = 'Clear REPL'}},
        {'<leader>sc', '<CMD>ReplRunCell<CR>', mode = 'n', {desc = 'Send cell to REPL'}},
        {'<leader>sl', '<Plug>ReplSendLine',   mode = 'n', {desc = 'Send line to REPL'}},
        {'<leader>ss', '<Plug>ReplSendVisual', mode = 'v', {desc = 'Send selection to REPL'}}
    },
}
