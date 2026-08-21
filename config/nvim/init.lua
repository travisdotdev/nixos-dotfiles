require("vim._core.ui2")
require('options')

-- ========================
-- PLUGINS 
-- ========================
vim.pack.add {
	'https://github.com/catppuccin/nvim',
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/folke/snacks.nvim',
	'https://github.com/windwp/nvim-autopairs',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/folke/which-key.nvim',
	'https://github.com/akinsho/toggleterm.nvim',
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/nvim-lualine/lualine.nvim',
	'https://github.com/nvim-neo-tree/neo-tree.nvim',
	'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/akinsho/bufferline.nvim',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
    'https://github.com/folke/lazydev.nvim',
    'https://github.com/mfussenegger/nvim-dap-python',
	'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
	'https://github.com/RRethy/base16-nvim',
	'https://github.com/slugbyte/lackluster.nvim',
	'https://github.com/kungfusheep/mfd.nvim',
	{
		src = 'https://github.com/saghen/blink.cmp',
		version = vim.version.range('1.0'),
	},
	{
		src = 'https://github.com/nvim-treesitter/nvim-treesitter',
		branch = 'main',
		build = ':TSUpdate',
	},
}

require('plugins')
require('keymaps')
require('lsp')
require('blink')
require('bufferline_config')
require('debugger')


-- -- ========================
-- -- COLOR SCHEMES 
-- -- ========================

--vim.cmd.colorscheme('tokyonight')
--vim.cmd.colorscheme('base16-black-metal-gorgoroth')
--vim.cmd.colorscheme('base16-darkviolet')
--vim.cmd.colorscheme('base16-eris')
vim.cmd.colorscheme('base16-nova')
--vim.cmd.colorscheme('lackluster-hack')
--vim.cmd.colorscheme('mfd-lumon')
--vim.cmd.colorscheme('base16-rebecca')

-- -- ========================
-- -- EXTRA STUFF 
-- -- ========================

local function set_transparency()
	vim.api.nvim_set_hl(0, 'Normal', { bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'NormalFloat', {bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'SignColumn', {  bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = '#000000' })
	   vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { bg = '#000000' })
	vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = '#a01fff',
		undercurl = true, sp = '#737aa2' })
	vim.api.nvim_set_hl(0, 'Comment', { fg = '#57807c', italic = true})
	vim.api.nvim_set_hl(0, 'CursorLine', {bg = '#043a3b'})
	vim.api.nvim_set_hl(0, 'LineNr', { fg = '#05f8fc' })
end

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('user-transparency', { clear = true }),
    callback = set_transparency,
})
set_transparency()
