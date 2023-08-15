--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', 'https://github.com/folke/lazy.nvim.git',
        lazypath
    }
end
vim.opt.runtimepath:prepend(lazypath)

local plugins = {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            {'j-hui/fidget.nvim', tag = 'legacy'},
            'folke/neodev.nvim'
        }
    }, {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
        }
    }, {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }, {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {'nvim-lua/plenary.nvim'}
    }, {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    }, {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
        build = ':TSUpdate'
    },
    'folke/which-key.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-lualine/lualine.nvim',
    'morhetz/gruvbox',
    'vimwiki/vimwiki',
    'chrisbra/Colorizer',
--     {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
--     'rebelot/heirline.nvim', -- this is for UI, see astronvim/l/p/heirline.lua
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
require('gitsigns').setup()
require('fidget').setup()
require('which-key').setup()

-- require("bufferline").setup()

-- local bufferline = {
--     { condition = function ()
--         local tmp1 = vim.api.nvim_tabpage_list_wins(0)[1]
--         local tmp2 = vim.api.nvim_win_get_buf(tmp1)
--         print(tmp1)
--         print(tmp2)
--         return true
--     end,
--     provider = 'tree '
--     },
--     { provider = 'something'},
--     update = {'ModeChanged'}
-- 
-- }
-- 
-- require('heirline').setup({
--     tabline = bufferline
-- })

vim.g.vimwiki_list = {{path = '~/data/knowledge_vault', syntax = 'markdown', ext = '.md'}}
vim.g.vimwiki_global_ext = 0


vim.cmd.colorscheme 'gruvbox'
-- vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = ''
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', {silent = true})
vim.keymap.set({'n'}, '<leader>c', ':ColorToggle<CR>', {desc = '[c] Toggle color'})
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<leader>x', ':tabclose<CR>')
vim.keymap.set('n', '<leader>l', ':tabnext<CR>')
vim.keymap.set('n', '<leader>h', ':tabprevious<CR>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*'
})

require('telescope').setup({})
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

require("neo-tree").setup({
    close_if_last_window = true,
    window = {
        width = 30,
        mappings = {
            ["<cr>"] = "open_tabnew",
        },
    }
})

vim.keymap.set('n', '<leader>t', ':Neotree toggle<CR>', {desc = 'Toggle tree'})
-- local tsb = require('telescope.builtin')
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {desc = '[S]earch by [G]rep'})
-- vim.keymap.set('n', '<leader>ss', require('telescope.builtin').diagnostics({bufnr = 0}), {desc = '[S]earch [D]iagnostics'})
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, {desc = '[S]earch [D]iagnostics'})


require('nvim-treesitter.configs').setup({
    modules = {'highlight'},
    sync_install = false,
    ensure_installed = {'python', 'rust', 'c', 'cpp', 'lua', 'vimdoc', 'vim'},
    ignore_install = {},
    auto_install = false,

    highlight = {enable = true},
    indent = {enable = true},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            node_decremental = '<M-space>'
        }
    },
})

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {desc = 'Open floating diagnostic message'})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc = 'Open diagnostics list'})

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

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({ensure_installed = vim.tbl_keys(servers)})

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name]
        }
    end
}

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

print('Successfuly loaded.')

-- This is `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
