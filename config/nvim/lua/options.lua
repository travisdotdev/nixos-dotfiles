vim.g.mapleader = ' '

-- ========================
-- OPTIONS
-- ========================
vim.opt.termguicolors = true
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 --keep 10 lines to left/right of cursor

vim.opt.tabstop = 4 -- tabwidth
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vim.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true --copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensistive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = 'yes:1' -- always show a sign column
vim.opt.colorcolumn = "0" -- show a column at 100 position chars
vim.opt.showmatch = true -- show matching brackets 
vim.opt.cmdheight = 0 --single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in the statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup

vim.opt.hidden = true --allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enbale mouse support
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- set encoding

vim.opt.undofile = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.confirm = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.timeoutlen = 300
-- vim.o.fileformat = 'unix'
vim.opt.fillchars = { eob = " " }

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus' -- clipboard system sync
end)

vim.g.netrw_banner = 0
vim.opt.nu = true
vim.opt.inccommand = "split"
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
vim.opt.isfname:append("@-@")
vim.opt.guicursor = ""

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

