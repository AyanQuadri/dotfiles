return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		event = "BufReadPre",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"clangd",
					"rust_analyzer",
					"bashls",
					"html",
					"cssls",
					"ts_ls",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Enhanced capabilities for autocompletion
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if has_cmp then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end

			-- Enhanced on_attach function
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- Navigation
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

				-- Documentation
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

				-- Code actions
				vim.keymap.set("n", "<leader>ka", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				-- Diagnostics
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

				-- Workspace management
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
			end

			-- Configure diagnostics display (VS Code-like) with modern signs
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					source = "if_many",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- Function to check if LSP server executable exists
			local function executable_exists(cmd)
				if type(cmd) == "table" then
					cmd = cmd[1]
				end
				return vim.fn.executable(cmd) == 1
			end

			-- Modern LSP configuration using vim.lsp.config (Neovim 0.11+)
			-- This is the future-proof way without deprecation warnings

			-- Lua Language Server
			if executable_exists("lua-language-server") then
				vim.lsp.config("lua_ls", {
					cmd = { "lua-language-server" },
					filetypes = { "lua" },
					root_markers = {
						".luarc.json",
						".luarc.jsonc",
						".luacheckrc",
						".stylua.toml",
						"stylua.toml",
						"selene.toml",
						"selene.yml",
					},
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					},
				})
			end

			-- Python Language Server
			if executable_exists("pyright-langserver") then
				vim.lsp.config("pyright", {
					cmd = { "pyright-langserver", "--stdio" },
					filetypes = { "python" },
					root_markers = {
						"pyproject.toml",
						"setup.py",
						"setup.cfg",
						"requirements.txt",
						"Pipfile",
						"pyrightconfig.json",
					},
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
							},
						},
					},
				})
			end

			-- TypeScript/JavaScript Language Server
			if executable_exists("typescript-language-server") then
				vim.lsp.config("ts_ls", {
					cmd = { "typescript-language-server", "--stdio" },
					filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
					root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						typescript = {
							preferences = {
								includePackageJsonAutoImports = "on",
							},
						},
						javascript = {
							preferences = {
								includePackageJsonAutoImports = "on",
							},
						},
					},
				})
			end

			-- C/C++ Language Server
			if executable_exists("clangd") then
				vim.lsp.config("clangd", {
					cmd = { "clangd" },
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
					root_markers = {
						".clangd",
						".clang-tidy",
						".clang-format",
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac",
						".git",
					},
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			-- Rust Language Server (uses Mason's rust-analyzer)
			if executable_exists("rust-analyzer") then
				vim.lsp.config("rust_analyzer", {
					cmd = { "rust-analyzer" },
					filetypes = { "rust" },
					root_markers = { "Cargo.toml", "rust-project.json" },
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
								allTargets = true,
							},
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
							},
							procMacro = {
								enable = true,
							},
							diagnostics = {
								enable = true,
								experimental = {
									enable = true,
								},
							},
							checkOnSave = {
								enable = true,
								command = "clippy",
							},
						},
					},
				})
			end

			-- Bash Language Server
			if executable_exists("bash-language-server") then
				vim.lsp.config("bashls", {
					cmd = { "bash-language-server", "start" },
					filetypes = { "sh", "bash" },
					root_markers = { ".git" },
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			-- HTML Language Server
			if executable_exists("vscode-html-language-server") then
				vim.lsp.config("html", {
					cmd = { "vscode-html-language-server", "--stdio" },
					filetypes = { "html" },
					root_markers = { "package.json", ".git" },
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			-- CSS Language Server
			if executable_exists("vscode-css-language-server") then
				vim.lsp.config("cssls", {
					cmd = { "vscode-css-language-server", "--stdio" },
					filetypes = { "css", "scss", "less" },
					root_markers = { "package.json", ".git" },
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			-- Auto-start LSP servers based on filetype
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				callback = function(args)
					local bufnr = args.buf
					local filetype = vim.bo[bufnr].filetype

					local server_map = {
						lua = "lua_ls",
						python = "pyright",
						typescript = "ts_ls",
						javascript = "ts_ls",
						typescriptreact = "ts_ls",
						javascriptreact = "ts_ls",
						c = "clangd",
						cpp = "clangd",
						objc = "clangd",
						objcpp = "clangd",
						cuda = "clangd",
						rust = "rust_analyzer",
						sh = "bashls",
						bash = "bashls",
						html = "html",
						css = "cssls",
						scss = "cssls",
						less = "cssls",
					}

					local config_name = server_map[filetype]
					if config_name then
						-- Enable the LSP using the config name (modern Neovim 0.11+ way)
						vim.lsp.enable(config_name)
					end
				end,
			})
		end,
	},
}
