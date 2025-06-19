local open_code = '\27[200~'
local close_code = '\27[201~'
local cr = '\13'

local format_python_lines = function(lines)
    local indent = 80
    for i = 1, #lines do
        local _, c = string.find(lines[i], '^[ ]*')
        local count = c or 0
        if count < indent then
            indent = count
        end
    end

    local new_lines = {}
    for i = 1, #lines do
        local x = string.sub(lines[i], indent + 1, string.len(lines[i]))
        table.insert(new_lines, x)
    end

    lines = new_lines

    if #lines == 1 then
        return {lines[1] .. cr}
    end

    local first = lines[1]
    local start = 2

    if string.sub(lines[1], 1, string.len('# %%')) == '# %%' then
        first = lines[2]
        start = 3
    end

    if string.sub(lines[1], 1, string.len('```{python}')) == '```{python}' then
        first = lines[2]
        start = 3
    end

    if string.sub(lines[1], 1, string.len('```{bash}')) == '```{bash}' then
        first = lines[2]
        start = 3
    end

    local new = {open_code .. first}
    for i = start, #lines - 1 do
        table.insert(new, lines[i])
    end

    if string.sub(lines[#lines], 1, 4) == '    ' then
        -- indented code needs 2 returns
        table.insert(new, lines[#lines])
        table.insert(new, close_code .. cr)
    else
        table.insert(new, lines[#lines] .. close_code .. cr)
    end

    return new
end

local quarto_select = function(meta)
    local options = {
        '1. bash',
        '2. python',
    }
    local choice = vim.fn.inputlist(options)
    if choice == 1 then
        return {'bash'}
    end
    if choice == 2 then
        return {'ipython', '--no-banner', '--nosep'}
    end
    return {'bash'}
end

return {
    'Vigemus/iron.nvim',
    config = function()
        local iron = require('iron.core')
        local view = require('iron.view')

        iron.setup{
            config = {
                scratch_repl = true,
                repl_definition = {
                    python = {
                        command = {'ipython', '--no-banner', '--nosep'},
                        format = format_python_lines,
                        block_dividers = {'# %%'},
                    },
                    fish = {
                        command = {'fish', '--init-command',
                            'function fish_prompt; echo -n "> "; end; function fish_right_prompt; end'
                        },
                        format = format_python_lines,
                        block_dividers = {'# %%'},
                    },
                    sh = {
                        command = {'bash'},
                        format = format_python_lines,
                        block_dividers = {'# %%'}
                    },
                    quarto = {
                        command = quarto_select,
                        format = format_python_lines,
                        block_dividers = {'```{bash}', '```{python}', '```'}
                    }
                },
                repl_filetype = function(bufnr, ft) return ft end,
                -- repl_open_cmd = view.split.vertical.rightbelow(80)
                -- repl_open_cmd = 'rightbelow vertical 80 split'
                repl_open_cmd = [[
                    Neotree close
                    setlocal winfixwidth
                    rightbelow vertical 80 split
                ]]
            },
            keymaps = {
                toggle_repl     = '<leader>rt',
                clear           = '<leader>rc',
                send_line       = '<leader>rl',
                send_code_block = '<leader>rb',
                visual_send     = '<leader>rv',
                exit            = '<leader>re',
                -- send_code_block_and_move = '<space>sn',
                -- restart_repl = '<space>rR', -- calls `IronRestart` to restart the repl
            },
            highlight = {italic = true},
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        }
        -- iron also has a list of commands, see :h iron-commands for all available commands
    end
}
