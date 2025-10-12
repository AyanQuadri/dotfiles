-- lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- auto-update parsers
    config = function()
      require("nvim-treesitter.configs").setup({
        -- languages to install
        ensure_installed = { "lua", "python", "javascript", "html", "css" },

        -- install parsers synchronously
        sync_install = false,

        -- auto-install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          enable = true,              -- enable syntax highlighting
          additional_vim_regex_highlighting = false,
        },

        indent = { enable = true },   -- enable smarter indentation
      })
    end,
  },
}
