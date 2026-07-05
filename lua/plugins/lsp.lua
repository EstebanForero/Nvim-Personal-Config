local servers = {
  "basedpyright",
  "clangd",
  "cssls",
  "eslint",
  "gopls",
  "html",
  "jdtls",
  "jsonls",
  "lua_ls",
  "nixd",
  "rust_analyzer",
  "tailwindcss",
  "taplo",
  "vtsls",
}

return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      { "mason-org/mason.nvim", opts = {} },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = servers,
          automatic_enable = servers,
        },
      },
    },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.lsp.enable(servers)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "biome",
        "clang-format",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "markdownlint",
        "nixfmt",
        "prettierd",
        "ruff",
        "shellcheck",
        "shfmt",
        "stylua",
        "tree-sitter-cli",
      },
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 24,
    },
  },
}
