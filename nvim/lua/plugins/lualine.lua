return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Option 1: Add type annotation to suppress warning
		---@diagnostic disable-next-line: undefined-field
		require("lualine").setup({
			options = {
				theme = "dracula", -- matches your colorscheme
				section_separators = { left = "", right = "" },
				component_separators = { left = "│", right = "│" },
				globalstatus = true, -- single statusline across splits
				icons_enabled = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			function()
				local reg = vim.fn.reg_recording()
				if reg == "" then
					return ""
				else
					return "Recording @" .. reg
				end
			end,
			color = { fg = "#ff9e64", gui = "bold" },

			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
					},
				},
				lualine_c = {
					{
						"buffers",
						show_filename_only = true,
						hide_filename_extension = false,
						show_modified_status = true,
						mode = 0, -- 0: shows buffer name, 1: shows buffer index, 2: shows buffer name + index
						max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component
						filetype_names = {
							TelescopePrompt = "Telescope",
							dashboard = "Dashboard",
							packer = "Packer",
							fzf = "FZF",
							alpha = "Alpha",
						},
						buffers_color = {
							-- Inactive buffers
							inactive = { fg = "#6c7086", bg = "#313244" },
							-- Active buffer (currently focused)
							active = { fg = "#000000", bg = "#93E2D5", gui = "bold" },
						},
						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							alternate_file = " ", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
						-- Custom formatting function for better readability
						fmt = function(str, context)
							-- Add some padding and visual separation
							if context.current then
								return " " .. str .. " " -- Active buffer with padding
							else
								return str -- Inactive buffers without extra padding
							end
						end,
					},
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = "󰠠 " },
						diagnostics_color = {
							error = { fg = "#f38ba8" },
							warn = { fg = "#fab387" },
							info = { fg = "#89dceb" },
							hint = { fg = "#a6e3a1" },
						},
					},
					{
						"filetype",
						colored = true,
						icon_only = false,
						icon = { align = "right" },
					},
				},
				lualine_y = {
					{
						"progress",
						fmt = function(str)
							return str .. "%%"
						end,
					},
				},
				lualine_z = {
					{
						"location",
						fmt = function(str)
							return " " .. str
						end,
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			-- Additional buffer navigation keymaps (optional)
			extensions = { "neo-tree", "lazy", "mason" },
		})
	end,
}
