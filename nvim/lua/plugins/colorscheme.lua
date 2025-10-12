return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- load before other plugins
		lazy = false, -- make sure we load this during startup
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- options: latte, frappe, macchiato, mocha
				background = { light = "latte", dark = "mocha" },
				transparent_background = true,
				neotree = true, -- Enable Neo-tree integration
				treesitter = true,
				telescope = true,
				lsp_trouble = true,
				mini = {
					enabled = true,
				},
				show_end_of_buffer = false,
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false,
				no_bold = false,
				no_underline = false,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				default_integrations = true,
				integrations = {
					-- Core integrations
					cmp = true,
					gitsigns = true,
					nvimtree = false, -- We use neo-tree
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},

					-- Your plugin integrations
					telescope = {
						enabled = true,
					},

					neotree = true, -- Changed from neo_tree to neotree

					alpha = true,

					mason = true,

					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},

					bufferline = true,
					markdown = true,
					semantic_tokens = true,
					lsp_trouble = true,
					fidget = true,
					illuminate = {
						enabled = true,
						lsp = false,
					},
				},
			})

			-- Set colorscheme immediately
			vim.cmd.colorscheme("catppuccin")

			-- Force reload colorscheme after a short delay to ensure plugins are loaded
			vim.defer_fn(function()
				vim.cmd("colorscheme catppuccin")
			end, 100)
		end,
	},
}
