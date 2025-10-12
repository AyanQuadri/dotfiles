return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				-- Enable git status
				enable_git_status = true,
				enable_diagnostics = true,
				
				default_component_configs = {
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "󰜌",
						default = "",
						highlight = "NeoTreeFileIcon",
					},
					name = {
						highlight = "NeoTreeFileName",
					},
					-- Git status configuration
					git_status = {
						symbols = {
							added = "✚",     -- or ""
							deleted = "✖",   -- or ""
							modified = "",  -- or ""
							renamed = "➜",   -- or ""
							untracked = "★", -- or ""
							ignored = "",   -- or ""
							unstaged = "✗",  -- or "󰄱"
							staged = "✓",    -- or ""
							conflict = "",  -- or ""
						},
					},
				},
				
				window = {
					position = "right",
					width = 35,
					-- Show file stats
					mappings = {
						["<space>"] = "none",
					},
				},
				
				filesystem = {
					follow_current_file = {
						enabled = true,
					},
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					-- Show git status in file tree
					components = {
						harpoon_index = function(config, node, state)
							-- Custom component if needed
						end,
					},
				},
			})
		end,
	},
}
