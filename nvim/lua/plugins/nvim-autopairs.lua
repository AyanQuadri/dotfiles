return
{
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,  -- use treesitter for smarter pairing
      disable_filetype = { "TelescopePrompt", "vim" },
    })
  end
}
