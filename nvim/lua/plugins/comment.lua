return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring", -- Smart commenting for embedded languages
	},
	config = function()
		local comment = require("Comment")
		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		comment.setup({
			-- Enable treesitter integration for smart commenting
			pre_hook = ts_context_commentstring.create_pre_hook(),

			-- Add which-key mappings
			padding = true, -- Add space between comment and code
			sticky = true, -- Keep cursor position when commenting
			ignore = "^$", -- Ignore empty lines

			-- Keybindings
			toggler = {
				line = "gcc", -- Toggle line comment (press gcc in normal mode)
				block = "gbc", -- Toggle block comment
			},
			opleader = {
				line = "gc", -- Line comment operator (use with motions like gcap)
				block = "gb", -- Block comment operator
			},
			extra = {
				above = "gcO", -- Add comment above current line
				below = "gco", -- Add comment below current line
				eol = "gcA", -- Add comment at end of line
			},
			mappings = {
				basic = true, -- Enable basic mappings (gcc, gbc)
				extra = true, -- Enable extra mappings (gcO, gco, gcA)
			},
		})
	end,
}
