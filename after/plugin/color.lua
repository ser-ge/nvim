-- vim.cmd("colorscheme gruvbox")
--
-- require("gruvbox").setup({
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = {
--     strings = true,
--     comments = true,
--     operators = false,
--     folds = true,
--   },
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "soft", -- can be "hard", "soft" or empty string
--   palette_overrides = {},
--   overrides = {},
--   dim_inactive = false,
--   transparent_mode = false,
-- })
-- vim.cmd("colorscheme gruvbox")
--

require('bamboo').setup  {
    -- Main options --
    style = 'vulgaris', -- Choose between 'vulgaris' (regular) and 'multiplex' (greener)
    toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
    toggle_style_list = { 'vulgaris', 'multiplex' }, -- List of styles to toggle between (this option is essentially pointless now but will become useful if more style variations are added)
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        conditionals = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
require('bamboo').load()
