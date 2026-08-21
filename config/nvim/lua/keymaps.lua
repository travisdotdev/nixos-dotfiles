-- ========================
-- KEYMAPS
-- ========================

-- jk to exit various modes 
vim.keymap.set('c', 'jk', '<C-c>',        { desc = 'Exit command mode' })
vim.keymap.set('i', 'jk', '<Esc>',         { desc = 'Exit insert mode' })
vim.keymap.set('v', 'jk', '<Esc>',         { desc = 'Exit visual mode' })
vim.keymap.set('t', 'jk', '<C-\\><C-n>',  { desc = 'Exit terminal mode' })

-- Window navigation 
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

-- Window resizing 
vim.keymap.set('n', '<C-Up>',    '<cmd>resize +2<cr>',          { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>',  '<cmd>resize -2<cr>',          { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>',  '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save file' })

-- Clear search highlights on Esc 
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Centered scrolling (from old config)
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })

-- Stay in visual mode when indenting 
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Move lines up/down in visual mode 
vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { desc = 'Move line up' })
vim.keymap.set('n', '<C-b>', '<C-v>',  {desc = 'Enter visual block mode'})

vim.keymap.set({ 'n', 'v' }, '<S-h>', '^', { desc = 'Go to start of line' })
vim.keymap.set({ 'n', 'v' }, '<S-l>', '$', { desc = 'Go to end of line' })

vim.api.nvim_create_user_command('StripCR', function()
    vim.cmd('%s/\r//ge')
    vim.bo.fileformat = 'unix'
end, { desc = 'Strip Windows line endings' })

vim.keymap.set('n', "<C-d>", "<C-d>zz", { desc = "Move down in buffer with cursor centered" })
vim.keymap.set('n', "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor centered" })

vim.keymap.set('n', 'n', 'nzzzv', { desc = "Next search result cursor centered" })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = "Previous search result cursor centered" })

vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, {desc = "Toggle Builtin Undotree"})

-- ========================
-- PLUGIN SPECIFIC KEYMAPS
-- ========================

-- Telescope 
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>sg', telescope.live_grep,  { desc = 'Live grep' })
vim.keymap.set('n', '<leader>sb', telescope.buffers,    { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>sc', telescope.colorscheme, { desc = 'Switch colorscheme' })

-- Neotree
vim.keymap.set('n', '\\', '<cmd>Neotree reveal<cr>', { desc = 'Neotree reveal', silent = true })
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle file explorer' })

-- Snacks
vim.keymap.set('n', '<leader>.', function() Snacks.scratch() end,                  { desc = 'Toggle scratch buffer' })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end,    { desc = 'Notification history' })
vim.keymap.set('n', '<leader>bx', function() Snacks.bufdelete() end,               { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>cR', function() Snacks.rename.rename_file() end,      { desc = 'Rename file' })
vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end,          { desc = 'Git blame line' })
vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end,               { desc = 'Git browse' })
vim.keymap.set('n', '<leader>ad', function() Snacks.dashboard() end,               { desc = 'Open dashboard' })
vim.keymap.set('n', ']]', function() Snacks.words.jump(vim.v.count1) end,          { desc = 'Next reference' })
vim.keymap.set('n', '[[', function() Snacks.words.jump(-vim.v.count1) end,         { desc = 'Prev reference' })

-- Bufferline
vim.keymap.set('n', '<Tab>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('gr', vim.lsp.buf.references, 'Go to references')
        map('gi', vim.lsp.buf.implementation, 'Go to implementation')
        map('grn', vim.lsp.buf.rename, 'Rename symbol')
        map('gra', vim.lsp.buf.code_action, 'Code action')
        map('K', vim.lsp.buf.hover, 'Hover documentation')
        map('gl', vim.diagnostic.open_float, 'Open diagnostic float')
        map('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
        map(']d', vim.diagnostic.goto_next, 'Next diagnostic')
    end,
})
