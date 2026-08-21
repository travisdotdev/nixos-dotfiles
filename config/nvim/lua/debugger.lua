local dap = require('dap')
local dapui = require('dapui')

local mason_debugpy = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
local python_path = vim.uv.fs_stat(mason_debugpy) and mason_debugpy or vim.fn.exepath('python3')
require('dap-python').setup(python_path)

require('dap-python').setup(debugpy_path)

dap.adapters.gdb = {
	type = 'executable',
	command = 'gdb',
	args = { '--interpreter=dap', '--quiet' },

}

dap.configurations.c = {
	{
		name = 'Launch',
		type = 'gdb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopAtBeginningOfMainSubprogram = true,
	},
}

dapui.setup {
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
        icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
        },
    },
}

vim.keymap.set('n', '<leader>pc', dap.continue, { desc = 'Debug: Continue/Start' })
vim.keymap.set('n', '<leader>px', dap.terminate, { desc = 'Debug: Terminate' })
vim.keymap.set('n', '<leader>pi', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<leader>po', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<leader>pO', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>pb', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>pB', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Debug: Conditional Breakpoint' })
vim.keymap.set('n', '<leader>pu', dapui.toggle, { desc = 'Debug: Toggle UI' })
vim.keymap.set('n', '<leader>p=', '<C-w>=', { desc = 'Debug: Equalise Windows' })


