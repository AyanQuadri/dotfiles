return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		local helpers = require("null-ls.helpers")

		-- Custom rustfmt formatter using your local rustfmt
		local rustfmt = {
			method = null_ls.methods.FORMATTING,
			filetypes = { "rust" },
			generator = helpers.formatter_factory({
				command = "/Users/syedayan/.rustup/toolchains/stable-aarch64-apple-darwin/bin/rustfmt",
				args = { "--emit=stdout", "--edition=2021" },
				to_stdin = true,
			}),
		}

		null_ls.setup({
			sources = {
				-- Lua language formatting
				null_ls.builtins.formatting.stylua,

				-- Python formatting
				null_ls.builtins.formatting.black,

				-- C/C++ formatting
				null_ls.builtins.formatting.clang_format,

				-- JavaScript/TypeScript formatting
				null_ls.builtins.formatting.prettier,

				-- Rust formatting with your local rustfmt
				rustfmt,
			},

			-- This integrates with your existing <leader>f keymap
			on_attach = function(client, bufnr)
				-- Enable formatting capability
				if client.supports_method("textDocument/formatting") then
					-- Your <leader>f keymap will automatically use none-ls formatters
					vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
				end
			end,

			-- Optional: Format on save (uncomment if you want auto-formatting)
			-- on_attach = function(client, bufnr)
			-- 	if client.supports_method("textDocument/formatting") then
			-- 		vim.api.nvim_create_autocmd("BufWritePre", {
			-- 			buffer = bufnr,
			-- 			callback = function()
			-- 				vim.lsp.buf.format({
			-- 					bufnr = bufnr,
			-- 					timeout_ms = 2000,
			-- 				})
			-- 			end,
			-- 		})
			-- 	end
			-- end,
		})
	end,
}

