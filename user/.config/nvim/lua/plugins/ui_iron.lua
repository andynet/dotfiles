local open_code = '\27[200~'
local close_code = '\27[201~'
local cr = '\13'

local format_python_lines = function(lines)
    local indent = 80
    for i = 1, #lines do
        local _, c = string.find(lines[i], "^[ ]*")
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

    if string.sub(lines[1], 1, string.len("# %%")) == "# %%" then
        first = lines[2]
        start = 3
    end

    -- if string.sub(lines[1], 1, string.len("```{python}")) == "```{python}" then
    --     first = lines[2]
    --     start = 3
    -- end

    local new = {open_code .. first}
    for i = start, #lines - 1 do
        table.insert(new, lines[i])
    end

    if string.sub(lines[#lines], 1, 4) == "    " then
        -- indented code needs 2 returns
        table.insert(new, lines[#lines])
        table.insert(new, close_code .. cr)
    else
        table.insert(new, lines[#lines] .. close_code .. cr)
    end

    return new
end

return {
    'Vigemus/iron.nvim',
    config = function()
        local iron = require('iron.core')
        local view = require('iron.view')
        -- local common = require('iron.fts.common')

        iron.setup{
            config = {
                scratch_repl = true,
                repl_definition = {
                    python = {
                        command = {'ipython', '--no-banner', '--nosep'},
                        format = format_python_lines,
                        block_dividers = {'# %%', "```{python}", "```"},
                    }
                },
                repl_filetype = function(bufnr, ft) return ft end,
                repl_open_cmd = view.split.vertical.rightbelow(80)
            },
            keymaps = {
                toggle_repl     = '<leader>rt',
                clear           = '<leader>rc',
                send_line       = '<leader>rl',
                send_code_block = '<leader>rb',
                visual_send     = '<leader>rv',
                -- send_code_block_and_move = '<space>sn',
                -- restart_repl = '<space>rR', -- calls `IronRestart` to restart the repl
            },
            highlight = {italic = true},
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        }
        -- iron also has a list of commands, see :h iron-commands for all available commands
    end
}
