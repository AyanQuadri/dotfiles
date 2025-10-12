return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],      
		}
		-- Buttons (like LazyVim setup) with custom highlight groups
		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
			dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
			dashboard.button("g", "  Live grep", ":Telescope live_grep<CR>"),
			dashboard.button("c", "  Config", ":Lazy<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		-- Apply custom highlighting to each button individually
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts = button.opts or {}
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end
		-- Update footer after Lazy has finished loading plugins
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val =
					"Welcome back sensei: ⚡ Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
		-- Layout: manually control padding
		dashboard.config.layout = {
			{ type = "padding", val = 0 },      -- top padding = 0, header starts at line 1
			dashboard.section.header,
			{ type = "padding", val = 0 },
			dashboard.section.buttons,
			{ type = "padding", val = 0 },
			dashboard.section.footer,
		}

		-- Function to set colors that integrate with Catppuccin
		local function setup_alpha_colors()
			-- Check if catppuccin is available
			local has_catppuccin, catppuccin = pcall(require, "catppuccin.palettes")
			
			if has_catppuccin then
				-- Use Catppuccin colors dynamically
				local colors = catppuccin.get_palette("mocha")
				vim.api.nvim_set_hl(0, "AlphaHeader", { fg = colors.pink, bold = true })
				vim.api.nvim_set_hl(0, "AlphaButtons", { fg = colors.blue, bold = true }) -- Changed to blue
				vim.api.nvim_set_hl(0, "AlphaFooter", { fg = colors.pink, italic = true })
				-- Specific highlights for button components
				vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = colors.blue, bold = true }) -- Keys in blue
				vim.api.nvim_set_hl(0, "AlphaButtonText", { fg = colors.blue, bold = true }) -- Text in blue
			else
				-- Fallback to your original colors
				vim.cmd("hi AlphaHeader guifg=#EE2A69 gui=bold")
				vim.cmd("hi AlphaButtons guifg=#89B4FA gui=bold") -- Blue for buttons
				vim.cmd("hi AlphaFooter guifg=#EE2A69 gui=italic")
				vim.cmd("hi AlphaShortcut guifg=#89B4FA gui=bold") -- Keys in blue
				vim.cmd("hi AlphaButtonText guifg=#89B4FA gui=bold") -- Text in blue
			end
		end

		-- Apply colors after colorscheme loads
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = setup_alpha_colors,
		})

		-- Set highlight group assignments
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"

		-- Disable automatic centering (this is crucial)
		dashboard.opts.opts.noautocenter = true
		
		-- Setup alpha
		alpha.setup(dashboard.opts)

		-- Apply colors immediately if catppuccin is already loaded
		setup_alpha_colors()
	end,
}
