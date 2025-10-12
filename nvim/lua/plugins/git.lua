return {
	-- Git inline signs and hunk actions
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				signcolumn = true, -- show signs in the gutter
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					follow_files = true,
				},
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = true, -- show blame for current line
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- end of line
					delay = 200,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Next git hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Previous git hunk" })

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage hunk" })
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset hunk" })
					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
					map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
					map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
					map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "Blame line" })
					map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
					map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })
					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end, { desc = "Diff this ~" })
					map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
				end,
			})
		end,
	},
	-- VS Code-like Git popup UI
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
			{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git commit" },
			{ "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Git pull" },
			{ "<leader>gP", "<cmd>Neogit push<cr>", desc = "Git push" },
		},
		config = function()
			require("neogit").setup({
				disable_signs = false,
				disable_hint = false,
				disable_context_highlighting = false,
				disable_commit_confirmation = false,
				disable_builtin_notifications = false,
				auto_refresh = true,
				sort_branches = "-committerdate",
				kind = "tab", -- "tab", "split", "split_above", "vsplit", "floating"
				console_timeout = 2000,
				auto_show_console = true,
				use_default_keymaps = true,
				commit_editor = {
					kind = "split",
				},
				commit_select_view = {
					kind = "tab",
				},
				commit_view = {
					kind = "vsplit",
					verify_commit = os.execute("which gpg") == 0, -- Can be set to true or false, otherwise we try to find the binary
				},
				log_view = {
					kind = "tab",
				},
				rebase_editor = {
					kind = "split",
				},
				reflog_view = {
					kind = "tab",
				},
				merge_editor = {
					kind = "split",
				},
				tag_editor = {
					kind = "split",
				},
				preview_buffer = {
					kind = "split",
				},
				popup = {
					kind = "split",
				},
				signs = {
					-- { CLOSED, OPENED }
					hunk = { "", "" },
					item = { ">", "v" },
					section = { ">", "v" },
				},
				integrations = {
					telescope = true,
					diffview = true,
				},
				sections = {
					sequencer = {
						folded = false,
						hidden = false,
					},
					untracked = {
						folded = false,
						hidden = false,
					},
					unstaged = {
						folded = false,
						hidden = false,
					},
					staged = {
						folded = false,
						hidden = false,
					},
					stashes = {
						folded = true,
						hidden = false,
					},
					unpulled_upstream = {
						folded = true,
						hidden = false,
					},
					unmerged_upstream = {
						folded = false,
						hidden = false,
					},
					unpulled_pushRemote = {
						folded = true,
						hidden = false,
					},
					unmerged_pushRemote = {
						folded = false,
						hidden = false,
					},
					recent = {
						folded = true,
						hidden = false,
					},
					rebase = {
						folded = true,
						hidden = false,
					},
				},
			})
		end,
	},
}
