require('lazydev').setup()

require('blink.cmp').setup {
    keymap = {
        preset = 'default',
    },
    appearance = {
        nerd_font_variant = 'mono',
    },
    completion = {
        menu = {
            auto_show = true,
            max_height = 5,
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
    },
    sources = {
        default = { 'lsp', 'path', 'lazydev' },
        providers = {
            lazydev = {
                module = 'lazydev.integrations.blink',
                score_offset = 100,
            },
        },
    },
    signature = { enabled = false},
}


