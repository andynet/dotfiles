return {{
    'mfussenegger/nvim-dap',
    config = function()
        local languages = require('languages')
        local dap = require('dap')

        for _, lang in pairs(languages) do
            if lang.dap then
                lang.dap(dap)
            end
        end

        vim.keymap.set('n', '<F1>', dap.continue, {desc = 'Debug: Start/Continue'})
        vim.keymap.set('n', '<F2>', dap.step_over, {desc = 'Debug: Step Over'})
        vim.keymap.set('n', '<F3>', dap.step_into, {desc = 'Debug: Step Into'})
        vim.keymap.set('n', '<F4>', dap.step_out, {desc = 'Debug: Step Out'})
        vim.keymap.set('n', '<F5>', dap.run_last, {desc = 'Debug: Rerun'})
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {desc = 'Debug: Toggle Breakpoint'})
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end, {desc = 'Debug: Set Breakpoint'})
    end
}, {
    'rcarriga/nvim-dap-ui',
    dependencies = {'nvim-neotest/nvim-nio'},
    requires = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'},
    config = function()
        local dapui = require('dapui')
        dapui.setup({
            controls = {enabled = false},
            layouts = {{
                elements = {{id = 'scopes', size = 1.0}},
                position = 'right',
                size = 0.25
            }, {
                elements = {
                    {id = 'console', size = 0.35, position = 'right'},
                    {id = 'repl',    size = 0.65, position = 'left'},
                },
                position = 'bottom',
                size = 0.25
            }}
        })
        vim.keymap.set('n', '<F6>', dapui.toggle, {desc = 'Dapui toggle'})
        vim.keymap.set('n', 'E', dapui.eval, {desc = 'Dapui eval'})
    end
}}
