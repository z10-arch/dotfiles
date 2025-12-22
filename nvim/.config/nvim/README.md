# 🚀 My Neovim Configuration

A modern, feature-rich Neovim setup based on [LazyVim](https://www.lazyvim.org/) with additional customizations for development, debugging, and productivity.

## ✨ Features

### 🐛 Debugging (DAP)
- Full Debug Adapter Protocol support with UI
- **Supported Languages**: Python, Go, JavaScript/TypeScript, C/C++/Rust
- Virtual text showing variable values inline
- Automatic debug adapter installation via Mason

### 📋 Clipboard (OSC52)
- Clipboard synchronization over SSH/tmux
- Works seamlessly in remote environments
- Automatic yank-to-system-clipboard

### 💾 Auto-save
- Automatically saves files on insert leave, buffer changes, and focus loss
- Toggle on/off with `:AutoSaveToggle`
- Safe for LSP operations

### 🎨 Transparency
- Transparent background showing terminal theme
- Automatically applies to all colorschemes
- Easy to toggle in config

### 🔍 Telescope Fuzzy Finder
- Lightning-fast file finding and text searching
- Git integration (commits, status, branches)
- LSP integration (references, definitions, symbols)
- FZF native sorter for performance

### 📁 Yazi File Manager
- Modern terminal-based file manager integration
- Fast navigation and file operations
- Seamless Neovim buffer integration

### 🔀 Tmux + Neovim Navigation
- Seamless navigation between tmux panes and Neovim windows
- Use `Ctrl+h/j/k/l` everywhere
- No context switching needed

## 📦 Installation

### Prerequisites

```bash
# Required
- Neovim >= 0.9.0
- Git
- A Nerd Font (for icons)
- ripgrep (for Telescope live grep)

# Optional but recommended
- tmux (for tmux navigation)
- yazi (for file manager)
- make (for Telescope FZF native)
- Node.js (for JS/TS debugging)
- Python 3 (for Python debugging)
- Go (for Go debugging)
- Delve (Go debugger)
```

### Setup

1. **Backup your existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Install plugins**:
   ```vim
   :Lazy sync
   ```

5. **Restart Neovim** and enjoy!

## ⌨️ Keybindings

### General
| Key | Description |
|-----|-------------|
| `<Space>` | Leader key |

### File Navigation (Telescope)
| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | List buffers |
| `<leader>fh` | Search help tags |
| `<leader>fr` | Recent files |
| `<leader>fw` | Find word under cursor |
| `<leader>fc` | List commands |
| `<leader>fk` | List keymaps |

### File Manager (Yazi)
| Key | Description |
|-----|-------------|
| `<leader>-` | Open Yazi at current file |
| `<leader>_` | Open Yazi at working directory |
| `<Ctrl-Up>` | Resume last Yazi session |

#### Inside Yazi
| Key | Description |
|-----|-------------|
| `Enter` | Open file/directory |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<F1>` | Show help |
| `q` / `Esc` | Close Yazi |

### Debugging (DAP)
| Key | Description |
|-----|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Set conditional breakpoint |
| `<leader>dc` | Continue / Start debugging |
| `<leader>dt` | Terminate debug session |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |
| `<leader>dC` | Run to cursor |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate expression |
| `<leader>dr` | Toggle REPL |

#### Language-Specific Debugging
| Key | Description | Language |
|-----|-------------|----------|
| `<leader>dpt` | Debug test method | Python |
| `<leader>dpc` | Debug test class | Python |
| `<leader>dgt` | Debug Go test | Go |
| `<leader>dgl` | Debug last Go test | Go |

### Git (Telescope)
| Key | Description |
|-----|-------------|
| `<leader>gc` | Git commits |
| `<leader>gs` | Git status |
| `<leader>gb` | Git branches |

### LSP (Telescope)
| Key | Description |
|-----|-------------|
| `<leader>lr` | LSP references |
| `<leader>ld` | LSP definitions |
| `<leader>li` | LSP implementations |
| `<leader>ls` | LSP document symbols |
| `<leader>lw` | LSP workspace symbols |

### Navigation (Tmux + Neovim)
| Key | Description |
|-----|-------------|
| `<Ctrl-h>` | Navigate left (tmux panes / Neovim windows) |
| `<Ctrl-j>` | Navigate down (tmux panes / Neovim windows) |
| `<Ctrl-k>` | Navigate up (tmux panes / Neovim windows) |
| `<Ctrl-l>` | Navigate right (tmux panes / Neovim windows) |
| `<Ctrl-\>` | Navigate to previous (tmux panes / Neovim windows) |

### Auto-save
| Command | Description |
|---------|-------------|
| `:AutoSaveToggle` | Toggle auto-save on/off |

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── autocmds.lua       # Auto commands + transparency
│   │   ├── autosave.lua       # Auto-save configuration
│   │   ├── keymaps.lua        # Custom keymaps (LazyVim default)
│   │   ├── lazy.lua           # Lazy.nvim setup
│   │   └── options.lua        # Neovim options (LazyVim default)
│   └── plugins/
│       ├── dap.lua            # Debug Adapter Protocol setup
│       ├── osc52.lua          # OSC52 clipboard integration
│       ├── telescope.lua      # Fuzzy finder configuration
│       ├── yazi.lua           # File manager integration
│       └── tmux-navigator.lua # Tmux navigation
├── lazy-lock.json             # Plugin versions lockfile
└── README.md                  # This file
```

## 🎯 Plugin Highlights

### Core Plugins

- [LazyVim](https://github.com/LazyVim/LazyVim) - Neovim configuration framework
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager

### Added Plugins

#### Debugging
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) - Debug Adapter Protocol client
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - UI for nvim-dap
- [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) - Virtual text support
- [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) - Python debugging
- [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) - Go debugging
- [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim) - DAP adapter installer

#### Navigation & Search
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - FZF sorter
- [yazi.nvim](https://github.com/mikavilpas/yazi.nvim) - File manager integration
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Tmux/Neovim navigation

#### Utilities
- [nvim-osc52](https://github.com/ojroques/nvim-osc52) - OSC52 clipboard support

## 🛠️ Customization

### Toggle Transparency

Edit `~/.config/nvim/lua/config/autocmds.lua`:

```lua
-- Set to false to disable transparency
local transparent = true
```

### Modify Auto-save Behavior

Edit `~/.config/nvim/lua/config/autosave.lua` to customize events or toggle on/off by default.

### Add More Debug Adapters

Edit `~/.config/nvim/lua/plugins/dap.lua` and add to `ensure_installed`:

```lua
ensure_installed = {
  "python",
  "delve",
  "js-debug-adapter",
  "codelldb",
  -- Add more here
},
```

### Customize Keybindings

Override any keybinding in `~/.config/nvim/lua/config/keymaps.lua` or in the respective plugin file.

## 🐛 Debugging Setup

### Python
```bash
# Install debugpy
pip install debugpy
```

### Go
```bash
# Install delve
go install github.com/go-delve/delve/cmd/dlv@latest
```

### JavaScript/TypeScript
Debug adapters are automatically installed via Mason.

### Usage
1. Open a file
2. Set a breakpoint: `<leader>db`
3. Start debugging: `<leader>dc`
4. Use step commands: `<leader>dO` (over), `<leader>di` (into), `<leader>do` (out)
5. Inspect variables in the DAP UI sidebar

## 🔍 Telescope Usage

### Find Files
```vim
<leader>ff
" Type to fuzzy search, Enter to open
" <C-x> horizontal split, <C-v> vertical split
```

### Search Text in Project
```vim
<leader>fg
" Type search term, see live results with preview
```

### Navigate Buffers
```vim
<leader>fb
" Fuzzy search open buffers
```

## 📁 Yazi File Manager

### Open Yazi
```vim
<leader>-
" Navigate with arrow keys
" Enter to open, q to quit
```

### Features
- Fast navigation
- File preview
- Multiple selection
- Integration with Neovim buffers
- Open in splits or tabs

## 🔀 Tmux Integration

### Setup
1. Install tmux plugin manager (TPM)
2. Add to `~/.tmux.conf`:
   ```bash
   set -g @plugin 'christoomey/vim-tmux-navigator'
   ```
3. Install plugins: `Ctrl+Space` then `I`
4. Restart tmux

### Usage
- Navigate seamlessly between tmux panes and Neovim windows with `Ctrl+h/j/k/l`
- No need to think about whether you're in tmux or Neovim

## 📝 Tips & Tricks

### Quick File Navigation
```vim
" Recently edited files
<leader>fr

" Search for word under cursor in project
<leader>fw

" Command history
<leader>f:
```

### Debugging Tips
```vim
" Conditional breakpoint
<leader>dB
" Then enter condition: x > 10

" Evaluate expression
<leader>de
" Select expression in visual mode first
```

### Yazi Tips
- Press `<Tab>` to cycle through open buffers
- Press `<C-y>` to copy relative paths
- Press `<C-s>` to grep in directory

## 🤝 Contributing

Feel free to fork and customize this configuration for your needs. If you have suggestions or improvements, please open an issue or pull request!

## 📄 License

This configuration is open source and available under the MIT License.

## 🙏 Credits

- [LazyVim](https://github.com/LazyVim/LazyVim) - Base configuration
- [Neovim](https://neovim.io/) - The editor
- All plugin authors - For their amazing work

## 📚 Resources

- [LazyVim Documentation](https://www.lazyvim.org/)
- [Neovim Documentation](https://neovim.io/doc/)
- [Telescope Documentation](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-dap Documentation](https://github.com/mfussenegger/nvim-dap)
- [Yazi Documentation](https://yazi-rs.github.io/)

---

**Happy Coding! 🎉**
