return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",  -- only load when you run :UndotreeToggle
    keys = {
      { "<leader>u", ":UndotreeToggle<CR>", desc = "Toggle UndoTree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2  -- vertical split
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_RelativeTimestamp = 1

      -- size tweaks
      vim.g.undotree_SplitWidth = 21        -- width of the history panel
      vim.g.undotree_DiffpanelHeight = 4    -- height of the diff panel

    end,
  },
}
