return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				cmdline = {
					enabled = true, -- enable custom commandline
					view = "cmdline_popup", -- floating popup
					format = {
						cmdline = { pattern = "^:", icon = "", lang = "vim" },
						search_down = { kind = "search", icon = " ", lang = "regex" },
						search_up = { kind = "search", icon = " ", lang = "regex" },
					},
				},
				messages = {
					enabled = true,
					-- Filter out lualine notifications
					view_error = "notify",
					view_warn = "notify",
					view_history = "messages",
					view_search = "virtualtext",
				},
				popupmenu = {
					enabled = true,
					backend = "nui",
				},
				-- Add routes to filter specific messages
				routes = {
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "lualine:" },
								{ find = "There are some issues with your config" },
								{ find = "LualineNotices" },
							},
						},
						opts = { skip = true }, -- This will completely skip these notifications
					},
				},
			})
			-- Setup notify (used by noice for messages)
			require("notify").setup({
				top_down = false, -- bottom to top (bottom positioning)
				max_width = 30, -- shorten width
				stages = "fade_in_slide_out", -- fade effect
				timeout = 3000, -- auto fade after 3s
				-- Position at bottom right
				render = "compact",
				minimum_width = 20,
				icons = {
					ERROR = "",
					WARN = "",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},
				background_colour = "#000000",
			})
			-- Make notify the default notification handler
			vim.notify = require("notify")
		end,
	},
}
