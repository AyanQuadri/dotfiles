-- lua/config/keymaps.lua

-- Options for mappings
local opts = { noremap = true, silent = true }

-- Leader + mdp to toggle Markdown preview
vim.keymap.set("n", "<leader>mdp", "<cmd>MarkdownPreviewToggle<CR>", { noremap = true, silent = true })

-- Remap jj to escape in insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", opts)

vim.api.nvim_set_keymap("v", "jk", "<Esc>", opts)

-- Telescope bindings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })

-- Open Lazy
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { noremap = true, silent = true, desc = "Open Lazy.vim" })

-- Open Neo-tree in right sidebar
vim.keymap.set("n", "<leader>nt", ":Neotree toggle right<CR>", { desc = "Toggle Neo-tree on right" })

-- Open Neo-tree showing buffers
vim.keymap.set("n", "<leader>b", ":Neotree toggle buffers left<CR>", { desc = "Neo-tree Buffers" })

-- Open Neo-tree showing git status
vim.keymap.set("n", "<leader>g", ":Neotree toggle git_status left<CR>", { desc = "Neo-tree Git" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })

-- Mason keymap
vim.keymap.set("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Open Mason UI" })

-- Optional: directional movement like VSCode
vim.keymap.set("n", "<leader>Wh", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>Wj", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<leader>Wk", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<leader>Wl", "<C-w>l", { desc = "Move to right window" })

-- Mini.files keymaps (add to your keymaps.lua)
-- Mini.files keymaps (simplest version)
vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Open mini.files" })
vim.keymap.set(
	"n",
	"<leader>E",
	"<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
	{ desc = "Open mini.files at current file" }
)

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = false })
	vim.api.nvim_command("write")

	-- Wait a moment for diagnostics to update after save
	vim.defer_fn(function()
		local diagnostics = vim.diagnostic.get(0)
		if #diagnostics > 0 then
			vim.diagnostic.open_float(nil, {
				focus = false,
				scope = "cursor",
			})
		else
			print("No diagnostics found")
		end
	end, 100)
end, { desc = "Format, save, and show diagnostics" })
