-- lua/config/options.lua

vim.opt.termguicolors = true -- Enable 24-bit RGB colors

-- Reduce delay before CursorHold triggers (default is 4000ms)
vim.opt.updatetime = 150

-- Line numbers
vim.opt.number = true

-- Indentation settings
vim.opt.shiftwidth = 2     -- How many spaces for autoindent
vim.opt.tabstop = 2        -- How many spaces a tab counts for
vim.opt.softtabstop = 2    -- How many spaces <Tab> feels like in insert mode
vim.opt.expandtab = true   -- Convert tabs to spaces

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
