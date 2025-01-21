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
vim.opt.expandtab = false

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
vim.keymap.set('n', '<leader>ss', ':setlocal spell!<cr>')

vim.keymap.set('n', '<leader>sn', ']s')
vim.keymap.set('n', '<leader>sp', '[s')
-- Add the word to the dictionary.
vim.keymap.set('n', '<leader>sa', 'zg')
-- Show suggestions.
vim.keymap.set('n', '<leader>s?', 'z=')

-- Fast writing.
vim.keymap.set('n', '<leader>w', ':w<cr>')

-- Easier auto suggestions.
vim.keymap.set('i', 'NN', '<C-n>')

-------------------
-- Auto commands. --
-------------------
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

-- Python.
vim.g.python3_host_prog = '/Users/franek/.pyenv/shims/python3'
vim.g.python_host_prog = '/Users/franek/.pyenv/shims/python'

