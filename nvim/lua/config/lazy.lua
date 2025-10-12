-- lua/config/lazy.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys before loading any plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- absolute line number
vim.opt.number = true

-- relative line number
vim.opt.relativenumber = true

-- Using the plugin folder for cleaner look
require("lazy").setup("plugins")

-- Neo-tree setup
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  window = {
    width = 25,              -- adjust width (default ~40, you can make it smaller)
    mappings = {
      ["h"] = "close_node",  -- collapse
      ["l"] = "open",        -- expand/open
      ["<cr>"] = "noop",     -- disable Enter (optional)
    },
  },
  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    hijack_netrw_behavior = "open_default",
    filtered_items = {
      visible = true,          -- show hidden files by default
      hide_dotfiles = false,   -- don't hide dotfiles (.zshrc, .gitignore, etc.)
      hide_gitignored = false, -- don't hide gitignored files
    },
  },
})
