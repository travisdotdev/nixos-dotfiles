require('telescope').setup({
    defaults = {
        winblend = 20,
    },
    pickers = {
        colorscheme = {
            enable_preview = true,
        },
    },
})
require('which-key').setup({})
require('nvim-autopairs').setup({})
require('toggleterm').setup({
    size = 15,
    open_mapping = '<leader>tf',
    direction = 'horizontal',
	shade_terminals = false,
})
require('lualine').setup({
	options = {
		theme = 'tokyonight',
		icons_enabled = true,
	}
})
require('neo-tree').setup({
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		window = {
			mappings = {
				['\\'] = 'close_window',
			},
		},
	},
})
local setup_treesitter = function()
    local treesitter = require('nvim-treesitter')
    treesitter.setup({})
    local ensure_installed = {
        'vim', 'vimdoc', 'lua',
        'c', 'cpp',
        'javascript', 'typescript',
        'html', 'css', 'json',
        'markdown', 'bash',
    }
    local config = require('nvim-treesitter.config')
    local already_installed = config.get_installed()
    local parsers_to_install = {}
    for _, parser in ipairs(ensure_installed) do
        if not vim.tbl_contains(already_installed, parser) then
            table.insert(parsers_to_install, parser)
        end
    end
    if #parsers_to_install > 0 then
        treesitter.install(parsers_to_install)
    end
    local group = vim.api.nvim_create_augroup('TreeSitterConfig', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
        group = group,
        callback = function(args)
            if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
                vim.treesitter.start(args.buf)
            end
        end,
    })
end
setup_treesitter()
require('gitsigns').setup({
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end, { desc = 'Jump to next git change' })

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end, { desc = 'Jump to previous git change' })

        -- Actions
        map('v', '<leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = 'Git stage hunk' })
        map('v', '<leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = 'Git reset hunk' })
        map('n', '<leader>hs', gitsigns.stage_hunk,                    { desc = 'Git stage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk,                    { desc = 'Git reset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer,                  { desc = 'Git stage buffer' })
        map('n', '<leader>hR', gitsigns.reset_buffer,                  { desc = 'Git reset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk,                  { desc = 'Git preview hunk' })
        map('n', '<leader>hb', gitsigns.blame_line,                    { desc = 'Git blame line' })
        map('n', '<leader>hd', gitsigns.diffthis,                      { desc = 'Git diff against index' })
        map('n', '<leader>hD', function() gitsigns.diffthis('@') end,  { desc = 'Git diff against last commit' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame,     { desc = 'Toggle git blame line' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline,           { desc = 'Toggle git show deleted' })
    end,
})
require('snacks').setup({
    bigfile = { enabled = true },
    dashboard = {
        enabled = true,
        preset = {
            header = (function()
				local headers = {
[[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
[[
   / | / /__  ____ _   __(_)___ ___
  /  |/ / _ \/ __ \ | / / / __ `__ \
 / /|  /  __/ /_/ / |/ / / / / / / /
/_/ |_/\___/\____/|___/_/_/ /_/ /_/]],
[[
┌┐┌┌─┐┌─┐┬  ┬┬┌┬┐
│││├┤ │ │└┐┌┘││││
┘└┘└─┘└─┘ └┘ ┴┴ ┴]],
[[                                                                 
 	_/      _/                      _/      _/  _/                 
 	_/_/    _/    _/_/      _/_/    _/      _/      _/_/_/  _/_/   
   _/  _/  _/  _/_/_/_/  _/    _/  _/      _/  _/  _/    _/    _/  
  _/    _/_/  _/        _/    _/    _/  _/    _/  _/    _/    _/   
 _/      _/    _/_/_/    _/_/        _/      _/  _/    _/    _/    
]],

				}
				math.randomseed(os.time())
				return headers[math.random(#headers)]
			end)(),
			keys = {
                { icon = ' ', key = 'f', desc = 'Find File',    action = ':Telescope find_files' },
                { icon = ' ', key = 'n', desc = 'New File',     action = ':ene | startinsert' },
                { icon = ' ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
                { icon = ' ', key = 'g', desc = 'Find Text',    action = ':Telescope live_grep' },
                { icon = ' ', key = 'c', desc = 'Config',       action = ':e ~/.config/nvim-new/init.lua' },
                { icon = ' ', key = 'q', desc = 'Quit',         action = ':qa' },
            },
        },
        sections = {
            { section = 'header' },
            { section = 'keys',      gap = 1, padding = 2 },
            { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
            { pane = 2, icon = ' ', title = 'Projects',     section = 'projects',     indent = 2, padding = 1 },
            {
                pane = 2,
                icon = ' ',
                title = 'Git Status',
                section = 'terminal',
                enabled = function()
                    return Snacks.git.get_root() ~= nil
                end,
                cmd = 'git status --short --branch --renames',
                height = 5,
                padding = 1,
                indent = 3,
            },
        },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
        notification = {
            wo = { wrap = true },
        },
    },
})

