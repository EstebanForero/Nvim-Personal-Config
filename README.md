# Neovim configuration

A modular, non-AI Neovim 0.12+ configuration built around native LSP APIs, Oxocarbon, Blink completion, Snacks and Trouble.

## Requirements

- Neovim 0.12 or newer
- Git, a C compiler, Make and Cargo
- A Nerd Font with glyph support
- `rg` and `fd` for searching
- Language runtimes required by your servers, including Node.js for web tooling
- Optional: `lazygit` for `<leader>gl`

## Install

```sh
./scripts/install.sh
```

On first launch, `lazy.nvim` installs plugins and Mason installs configured language tooling, including the Tree-sitter CLI required by the bleeding-edge Treesitter branch. Use `:checkhealth` if a language server cannot start.

## Keymap layout

Press `<leader>` and wait for WhichKey, or press `<leader>?` for buffer-local mappings.

| Prefix | Purpose |
| --- | --- |
| `<leader>f` | Find files, text, commands and keymaps |
| `<leader>c` | Code actions, formatting, symbols and diagnostics |
| `<leader>g` | Git actions |
| `<leader>m` | Persistent project marks |
| `<leader>u` | UI toggles |
| `<leader>x` | Trouble diagnostics and LSP lists |

Global mappings live in `lua/config/keymaps.lua`. LSP mappings live in `lua/config/keymaps/lsp.lua`, and plugin mappings remain beside their plugin specification under `lua/plugins/`.

## Maintenance

- `:Lazy` manages plugins; `lazy-lock.json` keeps installations reproducible.
- `:Mason` manages language servers and external tools.
- `:ConformInfo` shows the formatter selected for the current buffer.
- `:Trouble symbols toggle` opens the document-symbol tree.
