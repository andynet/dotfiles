--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ';'       -- defines <Leader>
vim.g.maplocalleader = ';'  -- defines <LocalLeader>
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.vimwiki_list = {{path = '~/data/knowledge_vault', syntax = 'markdown', ext = '.md'}}
vim.g.vimwiki_global_ext = 0

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', 'https://github.com/folke/lazy.nvim.git', lazypath
    })
end
vim.opt.runtimepath:prepend(lazypath)

local nvim_dap = {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        local masondap = require('mason-nvim-dap')

        masondap.setup({
            automatic_installation= false,
            ensure_installed = {'codelldb'},
        })

        dap.adapters.lldb = {
            type = "server",
            port = "${port}",
            host = "127.0.0.1",
            executable = {
                command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
                args = { "--port", "${port}" },
            },
        }

-- https://neovim.io/doc/user/lua-guide.html#lua-guide
-- vim.cmd("packadd termdebug")
-- vim.keymap.set('n', '<C-D>', ':Termdebug<CR><C-w>j<C-w>j<C-w>L<C-w>h<C-w>k')

-- dap.configurations.python = {
--   {
--     type = 'python';
--     request = 'launch';
--     name = "Launch file";
--     program = "${file}";
--     pythonPath = function()
--       return '/usr/bin/python'
--     end;
--   },
-- }

--         local last_cmd = ""
--         local program = ""
--         local args = {}
--
--         local fn1 = function()
--             local cmd = vim.fn.input("Debug: ", last_cmd, 'file')
--             last_cmd = cmd
--             local splits = vim.split(cmd, " ")
--             if #splits > 0 then
--                 program = splits[1]
--                 if #splits > 1 then
--                     table.remove(splits, 1)
--                     args = splits
--                 end
--             end
--         end
--         https://www.reddit.com/r/neovim/comments/txfy9z/codelldb_configuration_for_nvimdap/

        dap.configurations.rust = {{
            type = 'lldb',
            request = 'launch',
            name = 'Launch',
            program = function ()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            args = function ()
                return vim.split(vim.fn.input('args: '), ' ')
            end
        }}

        local dapui_setup = {
            controls = {enabled = false},
            layouts = {{
                elements = {{id = "scopes", size = 1.0}},
                position = "right",
                size = 30
            },{
                elements = {
                    {id = "repl", size = 0.5},
                    {id = "console", size = 0.5}
                },
                position = "bottom",
                size = 10
            }}
        }
        dapui.setup(dapui_setup)

        vim.keymap.set('n', '<F1>', dap.continue,  { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F3>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F4>', dap.step_out,  { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<F5>', dap.run_last,  { desc = 'Debug: Rerun' })
        vim.keymap.set('n', '<F6>', dapui.toggle,  { desc = 'Debug: See last session result.' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Debug: Set Breakpoint' })
    end,
}

local nvim_lspconfig = {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        {'j-hui/fidget.nvim', tag = 'legacy'},
        'folke/neodev.nvim'
    }
}

local nvim_cmp = {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
    end,
}

local plugins = {
    nvim_lspconfig,
    nvim_cmp,
    nvim_dap,
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {'nvim-lua/plenary.nvim'}
    }, {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    }, {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    }, {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'folke/which-key.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-lualine/lualine.nvim',
    'morhetz/gruvbox',
    'vimwiki/vimwiki',
    'chrisbra/Colorizer',
    'ibab/vim-snakemake'
}

require('lazy').setup(plugins)

require('mason').setup()
require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = '|',
        section_separators = ''
    }
})

require('gitsigns').setup({})
require('fidget').setup()
require('which-key').setup()
require('neodev').setup()
require('telescope').setup({
    defaults = {
        sorting_strategy = 'ascending',
    }
})
require('nvim-tree').setup({
    renderer = {
        icons = {
            git_placement = 'after'
        }
    },
    filters = {
        git_ignored = false,
    },
})
require('nvim-treesitter.configs').setup({
    modules = {'highlight'},
    sync_install = false,
    ensure_installed = {'python', 'rust', 'c', 'cpp', 'lua', 'vimdoc', 'vim', 'json'},
    ignore_install = {},
    auto_install = false,

    highlight = {enable = true},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<M-Space>',
            node_incremental = '<M-Space>',
            node_decremental = '<M-b>'
        }
    },
})

-- [[ Configure LSP ]]
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then desc = 'LSP: ' .. desc end

        vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc})
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(
        bufnr, 'Format', function(_) vim.lsp.buf.format() end, {
            desc = 'Format current buffer with LSP'
        }
    )
end

local servers = {
    rust_analyzer = {},
    clangd = {},
    pylsp = {},
    lua_ls = {
        Lua = {
            workspace = {checkThirdParty = false},
            telemetry = {enable = false}
        }
    }
}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({ensure_installed = vim.tbl_keys(servers)})

mason_lspconfig.setup_handlers({
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name]
        }
    end
})

local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load() -- ???
luasnip.config.setup({})

local cmp_config = {
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'luasnip'}
    }
}

cmp.setup(cmp_config)

local bufferline_config = {
    options = {
        style_preset = require('bufferline').style_preset.minimal,
        numbers = 'buffer_id',
        buffer_close_icon = '',
        close_icon = '',
        -- name_formatter = function(buf) return vim.fn.pathshorten(buf.path) end,
        truncate_names = false,
        offsets = {{filetype = 'NvimTree', text = 'NvimTree', padding = 1}},
    },
    highlights = {}
}

require("bufferline").setup(bufferline_config)
-- end of plugin configuration

vim.cmd.colorscheme 'gruvbox'
vim.wo.number = true
vim.o.mouse = ''
vim.opt.clipboard:append('unnamedplus')
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.opt.listchars = "tab:> ,trail:."
vim.opt.list = true
vim.opt.colorcolumn = "80,120"
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.o.scrolloff = 5

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', {silent = true})
vim.keymap.set({'n', 'v'}, '<C-Space>', '<C-f>', {silent = true})
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
vim.keymap.set({'n'}, '<leader>c', ':ColorToggle<CR>', {desc = '[c] Toggle color'})
vim.keymap.set({'i', 'n'}, '<C-s>', '<ESC>:w<CR>')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<leader>x', ':bdelete<CR>:blast<CR>')
vim.keymap.set('n', '<leader>l', ':bnext<CR>')
vim.keymap.set('n', '<leader>h', ':bprevious<CR>')
vim.keymap.set('n', '<leader>n', ':nohlsearch<CR>')
vim.keymap.set('n', '<leader>p', require('nvim-tree.api').fs.copy.absolute_path, {desc = '[p] get absolute path'})
-- :echo buffer_name()
vim.keymap.set('n', 'x', '"_x')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})
vim.keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})
-- scroll after EOF
vim.keymap.set('n', 'j', "line('.') >= line('$') - 5 ? '<C-e>gj' : 'gj'", {expr = true, silent = true})

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = highlight_group,
    pattern = '*',
    callback = function() vim.highlight.on_yank() end,
})

-- do not start folded
-- autocmd BufReadPost,FileReadPost * normal zR
vim.api.nvim_create_autocmd(
    {'BufReadPost', 'FileReadPost'},
    {pattern = '*', command = 'normal zR'}
)

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set(
    'n', '<leader>?', require('telescope.builtin').oldfiles,
    {desc = '[?] Find recently opened files'}
)
vim.keymap.set(
    'n', '<leader>/', function()
        require('telescope.builtin').current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown {winblend = 10, previewer = false}
        )
    end,
    {desc = '[/] Fuzzily search in current buffer'}
)

local wrap = function(f, ...)
    local args = {...}
    return function() f(unpack(args)) end
end

local tsb = require('telescope.builtin')
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', {desc = 'Toggle tree'})
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {desc = '[S]earch by [G]rep'})
vim.keymap.set('n', '<leader>ss', wrap(tsb.diagnostics, {bufnr = 0}))
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, {desc = '[S]earch [D]iagnostics'})

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {desc = 'Open floating diagnostic message'})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc = 'Open diagnostics list'})

print('Successfuly loaded.')

-- This is `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
