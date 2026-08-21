require('bufferline').setup {
    options = {
        mode = 'buffers',
        numbers = 'none',
        path_components = 1,
        modified_icon = '●',
        buffer_close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        tab_size = 21,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true,
        separator_style = { '│', '│' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        show_tab_indicators = false,
        indicator = { style = 'none' },
        sort_by = 'insert_at_end',
    },
    highlights = {
        separator = {
            fg = '#434C5E',
        },
        buffer_selected = {
            bold = true,
            italic = false,
        },
    },
}

