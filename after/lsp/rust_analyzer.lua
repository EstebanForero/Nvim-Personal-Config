return {
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      check = { command = "clippy" },
      completion = { callable = { snippets = "add_parentheses" } },
      inlayHints = {
        bindingModeHints = { enable = true },
        closureReturnTypeHints = { enable = "with_block" },
        discriminantHints = { enable = "fieldless" },
        lifetimeElisionHints = { enable = "skip_trivial" },
      },
      procMacro = { enable = true },
    },
  },
}
