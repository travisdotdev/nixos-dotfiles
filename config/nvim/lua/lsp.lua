
local wanted = {
    ['pyright'] = 'pyright-langserver',
    ['lua-language-server'] = 'lua-language-server',
    ['clangd'] = 'clangd',
	['nil'] = 'nil',
}

local missing = {}
for pkg, exe in pairs(wanted) do
    if vim.fn.executable(exe) == 0 then
        table.insert(missing, pkg)
    end
end

local on_nix = vim.uv.fs_stat('/etc/NIXOS') ~= nil
if not on_nix then
    table.insert(missing, 'debugpy')
end

require('mason').setup {
    PATH = 'append',
}
require('mason-tool-installer').setup {
    ensure_installed = missing,
}

vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.config('pyright', {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
            },
        },
    },
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            completion = { callSnippet = 'Replace' },
            diagnostics = { disable = { 'missing-fields' } },
        },
    },
})

vim.lsp.config('nil_ls', {
	settings = {
		[ 'nil' ] = {
			formatting = { command = { 'nixfmt' } },
		},
	},
})

require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_enable = false,
}

vim.lsp.enable { 'pyright', 'lua_ls', 'clangd', 'nil_ls' }
