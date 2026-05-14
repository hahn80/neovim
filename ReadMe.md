# Neovim Config

Neovim >= 0.12 configuration with native LSP, built-in treesitter, and modern plugins.

---

## Requirements

### Neovim

Install unstable version:

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install nvim
```

### Fuzzy Search

Required by the `fzf-lua` plugin for fuzzy finding.
Install the latest release from https://github.com/junegunn/fzf/releases

```bash
# Ubuntu/Debian
sudo apt install fzf

# Or install latest from GitHub (e.g. v0.72)
curl -LO https://github.com/junegunn/fzf/releases/download/v0.72.0/fzf-0.72.0-linux_amd64.tar.gz
tar -xzf fzf-0.72.0-linux_amd64.tar.gz
sudo mv fzf /usr/local/bin/fzf
```

### Search Text

Required for project-wide text search (`<Space>sg`).

```bash
sudo apt install ripgrep
```

### Clipboard

Required so Neovim can read/write the system clipboard (copy to gedit, terminals, etc.).

```bash
# X11
sudo apt install xclip

# Wayland
sudo apt install wl-clipboard
```

### LSP Servers

Install the language servers for the languages you work with:

| Language         | Server binary              | Install command                                      |
| ---------------- | -------------------------- | ---------------------------------------------------- |
| Lua              | `lua-language-server`      | https://github.com/LuaLS/lua-language-server/releases |
| Python           | `pyright-langserver`       | `pip install pyright`                                |
| C / C++          | `clangd`                   | `sudo apt install clangd`                            |
| JS / TS / React  | `typescript-language-server` | `npm install -g typescript-language-server typescript` |
| Markdown         | `marksman`                 | https://github.com/artempyanykh/marksman/releases    |

### Formatters

| Language   | Tool                | Install                          |
| ---------- | ------------------- | -------------------------------- |
| Python     | `black`             | `pip install black`              |
| C / C++    | `clang-format`      | `sudo apt install clang-format`  |
| JS / TS    | `prettier`          | `npm install -g prettier`        |
| Lua        | `stylua`            | `cargo install stylua`           |
| Markdown   | `prettier`          | (same as above)                  |

---

## Key Bindings

Leader key is **`<Space>`**.

### Files

| Key           | Action                              |
| ------------- | ----------------------------------- |
| `<C-p>`       | Find file by name (fuzzy)           |
| `<C-n>`       | Toggle file tree (neo-tree)         |
| `<Space>yy`   | Copy relative file path to clipboard |
| `<Space>yy`   | Copy path of selected file in tree  |

### Search

| Key           | Action                              |
| ------------- | ----------------------------------- |
| `<Space>sg`   | Live grep (search text in project)  |
| `<Space>sw`   | Grep word under cursor              |
| `<Space>.`    | Resume last search                  |
| `/`           | Search in current file              |
| `n` / `N`     | Next / prev match (consistent direction) |
| `<Esc>`       | Clear search highlight              |
| `<Space>s`    | Search & replace word under cursor  |

### Buffers

| Key           | Action                              |
| ------------- | ----------------------------------- |
| `gt` / `gT`   | Next / prev buffer                  |
| `<Space>sb`   | Pick buffer with fuzzy finder       |
| `<Space>q`    | Close current buffer                |

### Help & Navigation

| Key           | Action                              |
| ------------- | ----------------------------------- |
| `<Space>sh`   | Search help tags                    |
| `<Space>sk`   | Search all keymaps                  |

### LSP

| Key           | Action                              |
| ------------- | ----------------------------------- |
| `K`           | Hover documentation                 |
| `gd`          | Go to definition                    |
| `gD`          | Go to declaration                   |
| `gi`          | Go to implementation                |
| `gr`          | Go to references                    |
| `<Space>rn`   | Rename symbol                       |
| `<Space>ca`   | Code action                         |
| `<Space>e`    | Show diagnostic float               |
| `[d` / `]d`   | Prev / next diagnostic              |

### Formatting

| Key / Command     | Action                              |
| ----------------- | ----------------------------------- |
| `<Space>f`        | Format buffer                       |
| `:Format`         | Format buffer (command)             |
| `:FormatDisable`  | Disable auto-format globally        |
| `:FormatDisable!` | Disable auto-format for this buffer |
| `:FormatEnable`   | Re-enable auto-format               |

### Git (gitsigns)

| Key           | Action                              |
| ------------- | ----------------------------------- |
| `]c` / `[c`   | Next / prev git hunk                |
| `<Space>hs`   | Stage hunk                          |
| `<Space>hr`   | Reset hunk                          |
| `<Space>hS`   | Stage entire buffer                 |
| `<Space>hR`   | Reset entire buffer                 |
| `<Space>hp`   | Preview hunk                        |
| `<Space>hb`   | Blame current line (full)           |
| `<Space>hd`   | Diff this vs HEAD~1                 |
| `<Space>tb`   | Toggle inline git blame             |

### Editing

| Key           | Action                              |
| ------------- | ----------------------------------- |
| `<Alt-j>`     | Move line / selection down          |
| `<Alt-k>`     | Move line / selection up            |
| `> / <`       | Indent / outdent selection          |
| `U`           | Redo                                |
| `<C-c>`       | Copy line / selection to clipboard  |
