# Neovim Configuration 

My personal Neovim configuration with LSP, autocompletion, fuzzy finding, and modern UI enhancements.

## Features

- **LSP Support**: Full language server protocol integration with Mason
- **Smart Completion**: nvim-cmp with snippets and LSP sources
- **Fuzzy Finding**: Telescope for files, buffers, and live grep
- **File Explorer**: Neo-tree and Mini.files for file management
- **Modern UI**: Noice, notify, lualine, and catppuccin theme
- **Git Integration**: Gitsigns for inline git blame and hunks
- **Syntax Highlighting**: Treesitter for accurate parsing
- **Debugging**: DAP support for multiple languages
- **Auto-formatting**: None-ls for linting and formatting
- **Vi Keybindings**: `jj` to escape, familiar vim motions

## Prerequisites

- Neovim >= 0.11.0
- Git
- [Ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope live grep)
- [fd](https://github.com/sharkdp/fd) (optional, for faster file finding)
- Node.js (for LSP servers)
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)

## Installation

1. Install Neovim:
```bash
# macOS
brew install neovim

# Ubuntu/Debian (use PPA for latest)
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

2. Backup existing config:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

3. Clone and symlink:
```bash
# Symlink from dotfiles
ln -s ~/dotfiles/nvim ~/.config/nvim
```

4. Install dependencies:
```bash
# Install ripgrep and fd
brew install ripgrep fd

# Or on Ubuntu/Debian
sudo apt install ripgrep fd-find
```

5. Launch Neovim:
```bash
nvim
```
Lazy.nvim will automatically install all plugins on first launch.

6. Install LSP servers:
```
:Mason
```
Press `i` to install servers. Recommended: `lua_ls`, `pyright`, `ts_ls`, `clangd`, `rust_analyzer`

## Key Bindings

### General
| Key | Mode | Action |
|-----|------|--------|
| `<Space>` | n | Leader key |
| `jj` | i | Exit insert mode |
| `jk` | v | Exit visual mode |

### File Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fb` | n | Find buffers |
| `<leader>fh` | n | Find help tags |
| `<leader>e` | n | Open Mini.files |
| `<leader>E` | n | Open Mini.files at current file |
| `<leader>nt` | n | Toggle Neo-tree (right) |

### Buffer Management
| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | n | Next buffer |
| `<Shift-Tab>` | n | Previous buffer |
| `<leader>bd` | n | Close buffer |
| `<leader>b` | n | Neo-tree buffers (left) |

### LSP & Code
| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gi` | n | Go to implementation |
| `gr` | n | Find references |
| `gt` | n | Go to type definition |
| `K` | n | Hover documentation |
| `<C-k>` | n | Signature help |
| `<leader>ka` | n | Code actions |
| `<leader>rn` | n | Rename symbol |
| `<leader>f` | n | Format, save & show diagnostics |
| `]d` | n | Next diagnostic |
| `[d` | n | Previous diagnostic |
| `<leader>e` | n | Open diagnostic float |

### Git
| Key | Mode | Action |
|-----|------|--------|
| `<leader>g` | n | Neo-tree git status |
| `]h` | n | Next git hunk |
| `[h` | n | Previous git hunk |
| `<leader>hp` | n | Preview hunk |
| `<leader>hs` | n | Stage hunk |
| `<leader>hr` | n | Reset hunk |

### Window Management
| Key | Mode | Action |
|-----|------|--------|
| `<leader>Wh` | n | Move to left window |
| `<leader>Wj` | n | Move to below window |
| `<leader>Wk` | n | Move to above window |
| `<leader>Wl` | n | Move to right window |

### Plugin Management
| Key | Mode | Action |
|-----|------|--------|
| `<leader>L` | n | Open Lazy.nvim |
| `<leader>m` | n | Open Mason UI |

### Markdown
| Key | Mode | Action |
|-----|------|--------|
| `<leader>mdp` | n | Toggle Markdown preview |

## Plugin List

### Plugin Manager
- **[lazy.nvim](https://github.com/folke/lazy.nvim)**: Fast, modern plugin manager

### LSP & Completion
- **[mason.nvim](https://github.com/williamboman/mason.nvim)**: LSP/DAP/Linter installer
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)**: Mason-LSP bridge
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: LSP configurations
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**: Autocompletion engine
- **[none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)**: Formatting & linting

### Syntax & Editing
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**: Advanced syntax highlighting
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)**: Auto close brackets
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)**: Smart commenting

### File Navigation
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**: Fuzzy finder
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)**: File explorer
- **[mini.files](https://github.com/echasnovski/mini.files)**: Minimal file manager

### UI Enhancements
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)**: Statusline
- **[noice.nvim](https://github.com/folke/noice.nvim)**: Enhanced UI for messages/cmdline
- **[nvim-notify](https://github.com/rcarriga/nvim-notify)**: Notification manager
- **[alpha-nvim](https://github.com/goolord/alpha-nvim)**: Dashboard
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)**: Indent guides
- **[catppuccin](https://github.com/catppuccin/nvim)**: Colorscheme

### Git Integration
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**: Git decorations

### Debugging
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)**: Debug adapter protocol

### Utilities
- **[undotree](https://github.com/mbbill/undotree)**: Undo history visualizer
- **[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)**: Live markdown preview

## Supported Languages

LSP servers configured for:
- **Lua** (lua_ls)
- **Python** (pyright)
- **TypeScript/JavaScript** (ts_ls)
- **C/C++** (clangd)
- **Rust** (rust_analyzer)
- **Bash** (bashls)
- **HTML** (html)
- **CSS/SCSS** (cssls)

## Configuration Structure

```
nvim/
├── init.lua              # Entry point
├── lazy-lock.json        # Plugin versions lock
└── lua/
    ├── config/
    │   ├── lazy.lua      # Lazy.nvim setup
    │   ├── options.lua   # Vim options
    │   └── keymaps.lua   # Key mappings
    └── plugins/
        ├── lsp.lua           # LSP configuration
        ├── completion.lua    # nvim-cmp setup
        ├── telescope.lua     # Fuzzy finder
        ├── treesitter.lua    # Syntax highlighting
        ├── neo-tree.lua      # File explorer
        ├── minifile.lua      # Mini.files
        ├── lualine.lua       # Statusline
        ├── colorscheme.lua   # Theme
        ├── noice.lua         # UI enhancements
        ├── git.lua           # Git integration
        ├── dap.lua           # Debugging
        ├── none-ls.lua       # Formatting/linting
        ├── alpha.lua         # Dashboard
        ├── blankline.lua     # Indent guides
        ├── comment.lua       # Commenting
        ├── nvim-autopairs.lua # Auto pairs
        ├── markdown.lua      # Markdown tools
        └── undotree.lua      # Undo history
```

## Customization

### Change Colorscheme
Edit `lua/plugins/colorscheme.lua`:
```lua
return {
  "catppuccin/nvim",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme catppuccin-mocha") -- or catppuccin-latte, frappe, macchiato
  end,
}
```

### Add New LSP Server
1. Open Mason: `<leader>m`
2. Search and install server with `i`
3. Add to `lua/plugins/lsp.lua` in `ensure_installed` table
4. Configure in the same file following existing patterns

### Modify Keybindings
Edit `lua/config/keymaps.lua` to add or change mappings.

## Troubleshooting

**LSP not working:**
```vim
:LspInfo
:Mason
```
Ensure servers are installed and running.

**Treesitter errors:**
```vim
:TSUpdate
:TSInstall <language>
```

**Plugins not loading:**
```vim
:Lazy sync
:Lazy clean
:Lazy update
```

**Telescope can't find files:**
Install ripgrep and fd:
```bash
brew install ripgrep fd
```

**Icons not displaying:**
Install a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/) and set it in your terminal.

## Performance

- Lazy loading enabled for most plugins
- Startup time: ~60-80ms (with caching)
- Use `:Lazy profile` to check plugin load times

## Credits

Configuration inspired by LazyVim and the Neovim community.
