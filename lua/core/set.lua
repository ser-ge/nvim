vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"


-- Retrieve the current status line
local current_statusline = vim.opt.statusline:get()

-- Append a custom element to the status line
local new_statusline = current_statusline .. " %{FugitiveStatusline()}"

-- -- Prepend a custom element to the status line
-- new_statusline = "%{MyOtherCustomFunction()}" .. new_statusline

-- Set the new status line
vim.opt.statusline = new_statusline

-- auto yank to clipboard
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" and vim.v.event.regtype ~= "" then
            vim.fn.setreg('+', vim.fn.getreg('"'))
            vim.fn.setreg('*', vim.fn.getreg('"'))
        end
    end
})



-- local o = vim.opt

-- -- o.number         = true -- enable line number
-- -- o.relativenumber = true -- enable relative line number
-- o.cursorline     = true -- enable cursor line
-- o.expandtab      = true -- use spaces instead of tabs
-- o.autowrite      = true -- auto write buffer when it's not focused
-- o.hidden         = true -- keep hidden buffers
-- o.ignorecase     = true -- case insensitive on search..
-- o.smartcase      = true -- ..unless there's a capital
-- o.equalalways    = true -- make window size always equal
-- o.lazyredraw     = true -- make macro faster
-- o.list           = true -- display listchars
-- o.showmode       = false -- don't show mode
-- o.autoindent     = true -- enable autoindent
-- o.smarttab       = true -- make tab behaviour smarter
-- o.splitbelow     = true -- split below instead of above
-- o.splitright     = true -- split right instead of left
-- o.startofline    = false -- don't go to the start of the line when moving to another file
-- o.swapfile       = false -- disable swapfile
-- o.termguicolors  = true -- true colours for better experience
-- o.wrap           = false -- don't wrap lines
-- o.writebackup    = false -- disable backup
-- o.swapfile       = false -- disable swap
-- o.backupcopy     = "yes" -- fix weirdness for stuff that replaces the entire file when hot reloading
-- o.relativenumber = true
-- o.completeopt    = {
--   "menu",
--   "menuone",
--   "noselect",
--   "noinsert",
-- } -- better completion
-- o.encoding       = "UTF-8" -- set encoding
-- o.fillchars      = {
--   vert = "│",
--   eob = " ",
--   fold = " ",
--   diff = " ",
-- } -- make vertical split sign better
-- -- o.foldmethod     = "expr"
-- -- o.foldopen       = {
-- --   "percent",
-- --   "search",
-- -- } -- don't open fold if I don't tell it to do so
-- -- o.foldexpr       = "nvim_treesitter#foldexpr()"
-- -- o.foldlevel      = 99 -- don't fold anything if I don't tell it to do so
-- -- o.foldminlines   = 5 -- don't fold anything below 5 lines
-- -- o.foldnestmax    = 99
-- -- o.foldcolumn     = "1" -- enable fold column for better visualisation
-- o.inccommand     = "split" -- incrementally show result of command
-- o.listchars      = {
--   -- eol = "↲",
--   tab = "» ",
-- } -- set listchars
-- o.mouse          = "nvi" -- enable mouse support in normal, insert, and visual mode
-- o.shortmess      = "csa" -- disable some stuff on shortmess
-- o.signcolumn     = "yes" -- enable sign column all the time 4 column
-- o.shell          = "/usr/bin/zsh" -- use bash instead of zsh
-- -- o.colorcolumn    = { "80" } -- 80 chars color column
-- o.laststatus     = 3 -- always enable statusline
-- o.pumheight      = 10 -- limit completion items
-- o.re             = 0 -- set regexp engine to auto
-- o.scrolloff      = 2 -- make scrolling better
-- o.sidescroll     = 2 -- make scrolling better
-- o.shiftwidth     = 4 -- set indentation width
-- o.sidescrolloff  = 15 -- make scrolling better
-- o.tabstop        = 2 -- tabsize
-- o.timeoutlen     = 400 -- faster timeout wait time
-- o.updatetime     = 1000 -- set faster update time
-- o.joinspaces     = false
-- o.diffopt:append { "algorithm:histogram", "indent-heuristic" }

-- o.cmdheight = 2
-- o.incsearch = true
-- vim.wo.number = true

