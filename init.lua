-- Based on https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua
-- and https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim

-- Set leader to space.
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-- Don't fold.
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99

-- Always keep 7 lines context on screen when scrolling.
vim.opt.scrolloff = 7

-- Don't show line breaks if they are not there.
vim.opt.wrap = false

-- Use relative line numbers around the current line and an absolute line
-- number in current line.
vim.opt.relativenumber = true
vim.opt.number = true

-- Keep current content on top and left when splitting.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Infinite undo (ends up in ~/.local/state/nvim/undo/)
vim.opt.undofile = true

-- List all matches and only complete to the longest common match.
vim.opt.wildmode = 'list:longest'
-- Don't suggest some files.
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'

-- Tabs.
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Ignore case when searching.
vim.opt.ignorecase = true
-- Unless uppercase is in the search term.
vim.opt.smartcase = true

-- No sounds on errors.
vim.opt.vb = true

-- Show more hidden characters.
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

-- More useful diffs (nvim -d) by ignoring whitespace and smarter algorithms.
vim.opt.diffopt:append('iwhite')
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')

-- Show a column at 80 characters as a guide for long lines.
vim.opt.colorcolumn = '80'

--------------
-- Keymaps. --
--------------
-- Easier way to move between windows.
vim.keymap.set('n', '<C-j>', '<C-W>j') 
vim.keymap.set('n', '<C-k>', '<C-W>k') 
vim.keymap.set('n', '<C-h>', '<C-W>h') 
vim.keymap.set('n', '<C-l>', '<C-W>l') 

-- Disable highlight.
vim.keymap.set('n', '<leader><cr>', ':nohl<cr>', { silent = true })

-- Jump to start and end of line using the home row keys
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')

-- Toggle spellchecking.
vim.keymap.set('n', '<leader>sc', ':setlocal spell!<cr>')

-- Add the word to the dictionary.
vim.keymap.set('n', '<leader>sa', 'zg')
-- Show suggestions.
vim.keymap.set('n', '<leader>s?', 'z=')

-- Fast writing.
vim.keymap.set('n', '<leader>w', ':w<cr>')

-- Easier auto suggestions.
vim.keymap.set('i', 'NN', '<C-n>')

-- Toggle between buffers.
vim.keymap.set('n', '<leader><leader>', '<c-^>')

-- Always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })

-- Switch buffers with arrows.
vim.keymap.set('n', '<left>', ':bp<cr>')
vim.keymap.set('n', '<right>', ':bn<cr>')

-- Show/hide hidden characters.
vim.keymap.set('n', '<leader>,', ':set invlist<cr>')

-- Those need fzf and fzf-lua:
-- Quick-open files.
vim.keymap.set('', '<leader>f', '<cmd>FzfLua files<cr>')
-- Search buffers.
vim.keymap.set('n', '<leader>b', '<cmd>FzfLua buffers<cr>')
-- Grep.
vim.keymap.set('n', '<leader>gr', '<cmd>FzfLua grep_project<cr>')

--------------------
-- Auto commands. --
--------------------
-- Highlight yanked text.
vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
        pattern = '*',
        command = 'silent! lua vim.highlight.on_yank({ timeout = 500 })'
    }
)

-- Jump to last edit position on opening file.
vim.api.nvim_create_autocmd(
    'BufReadPost',
    {
        pattern = '*',
        callback = function(ev)
            if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
                -- Except for in git commit messages.
                -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
                if not vim.fn.expand('%:p'):find('.git', 1, true) then
                    vim.cmd('exe "normal! g\'\\""')
                end
            end
        end
    }
)

-- Needed to to appropriately highlight codefences returned from denols.
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

--------------
-- Plugins. --
--------------
if (not vim.g.vscode) then
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        spec = {
            {
                'sainnhe/gruvbox-material',
                lazy = false,
                priority = 1000,
                config = function()
                    vim.g.gruvbox_material_disable_italic_comment = true
                    vim.cmd.colorscheme('gruvbox-material')
                end
            },
            {
                'ggandor/leap.nvim',
                config = function()
                    require('leap').create_default_mappings()
                end
            },
            {
                'andymass/vim-matchup',
                config = function()
                    vim.g.matchup_matchparen_offscreen = { method = "popup" }
                end
            },
            {
                "ibhagwan/fzf-lua",
                -- optional for icon support
                dependencies = { "nvim-tree/nvim-web-devicons" },
                -- or if using mini.icons/mini.nvim
                -- dependencies = { "echasnovski/mini.icons" },
                opts = {}
            },
            {
                'echasnovski/mini.pairs',
                event = 'VeryLazy',
                version = 'false',
                opts = {}
            },
            {
                'lewis6991/gitsigns.nvim',
                lazy = false,
                opts = {}
            },
            {
                'nvim-lualine/lualine.nvim',
                dependencies = { 'nvim-tree/nvim-web-devicons' },
                options = { theme = 'gruvbox' },
                config = function()
                    require("lualine").setup()
                end,
            },
            {
                'neovim/nvim-lspconfig',
                config = function()
                    vim.lsp.enable('clangd')
                    -- vim.lsp.enable('denols')
                    vim.lsp.enable('pyright')
                    vim.lsp.enable('ts_ls')

                    -- Kemaps.
                    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
                    vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)
                    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
                    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action)
                end
            },
            -- Inline function signatures.
            {
                "ray-x/lsp_signature.nvim",
                event = "VeryLazy",
                opts = {
                    hint_prefix = {
                        above = "↙ ",  -- when the hint is on the line above the current line
                        current = "← ",  -- when the hint is on the same line
                        below = "↖ "  -- when the hint is on the line below the current line
                    },
                },
            },
            -- LSP-based code-completion.
            {
                "hrsh7th/nvim-cmp",
                -- Load cmp on InsertEnter.
                event = "InsertEnter",
                -- Dependencies are always lazy-loaded unless specified otherwise.
                dependencies = {
                    'neovim/nvim-lspconfig',
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-path",
                },
                config = function()
                    local cmp = require'cmp'
                    cmp.setup({
                        snippet = {
                            -- nvim-cmp requires a snippet engine.
                            expand = function(args)
                                vim.snippet.expand(args.body)
                            end,
                        },
                        mapping = cmp.mapping.preset.insert({
                            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                            ['<C-f>'] = cmp.mapping.scroll_docs(4),
                            ['<C-Space>'] = cmp.mapping.complete(),
                            ['<C-e>'] = cmp.mapping.abort(),
                            -- Accept currently selected item.
                            -- Set `select` to `false` to only confirm explicitly selected items.
                            ['<CR>'] = cmp.mapping.confirm({ select = true }),
                        }),
                        sources = cmp.config.sources({
                            { name = 'nvim_lsp' },
                        }, {
                            { name = 'path' },
                        }),
                        experimental = {
                            ghost_text = true,
                        },
                    })

                    -- Enable completing paths in :
                    cmp.setup.cmdline(':', {
                        sources = cmp.config.sources({
                            { name = 'path' }
                        })
                    })
                end
            },
        },
    })
end

-- Python.
vim.g.python3_host_prog = '~/.pyenv/shims/python3'
vim.g.python_host_prog = '~/.pyenv/shims/python'

