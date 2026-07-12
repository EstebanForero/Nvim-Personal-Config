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

To install the same configuration for Linux's root user as well, run the installer a second time with explicit root mode:

```sh
sudo ./scripts/install.sh --root
```

The default command links the repository to the current user's Neovim configuration directory. Root mode resolves root's home directory independently and links it to `<root-home>/.config/nvim`. Existing non-symlink configurations are moved to a timestamped backup before either link is created.

On first launch, `lazy.nvim` installs plugins and Mason installs only the core Lua and Tree-sitter tools. Mason-managed language servers are installed explicitly from `:Mason` and are enabled automatically once installed. This avoids downloading runtimes for languages you do not use.

## Language servers

Shared LSP capabilities and servers that cannot be managed automatically by Mason are declared in `lua/config/lsp.lua`. Server-specific overrides belong in `after/lsp/<server>.lua`; this keeps activation separate from individual server settings.

To add a language server:

1. Install it with `:Mason` when Mason supports it. `mason-lspconfig.nvim` enables installed servers automatically.
2. For a server provided externally or embedded in another application, add its name to `manually_enabled_servers` in `lua/config/lsp.lua`.
3. Add `after/lsp/<server>.lua` only when the server needs settings that differ from the `nvim-lspconfig` defaults.

### GDScript

GDScript is explicitly enabled because its language server is built into Godot rather than installed by Mason. The `gdtoolkit` and `gdscript-formatter` Mason packages provide linting and formatting tools; they do not provide the GDScript LSP.

See Godot's [external editor documentation](https://docs.godotengine.org/en/latest/tutorials/editor/external_editor.html) for its LSP and port settings.

For navigation, completion and diagnostics in a `.gd` buffer:

1. Open the same project in Godot and keep the Godot editor running.
2. Ensure the project contains `project.godot`.
3. Keep Godot's language-server port at its default, `6005`.
4. Open a project `.gd` file in Neovim. The configuration enables `gdscript` automatically and connects to Godot.

If Godot uses a different language-server port, start Neovim with the matching environment variable:

```sh
GDScript_Port=6007 nvim
```

With Neovim 0.12+, use these commands to inspect or control LSP state:

```vim
:checkhealth vim.lsp
:lsp enable gdscript
:lsp restart gdscript
:lua =vim.lsp.get_clients({ bufnr = 0 })
```

`:LspInfo` is a legacy `nvim-lspconfig` command and is not registered when Neovim's built-in `:lsp` command is available.

Configuration changes do not require a build step; restart Neovim or reload `nvim-lspconfig` through `:Lazy`.

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
- `:checkhealth vim.lsp` shows enabled configurations and active LSP clients.
- `:ConformInfo` shows the formatter selected for the current buffer.
- `:Trouble symbols toggle` opens the document-symbol tree.
