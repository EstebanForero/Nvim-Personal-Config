local icons = require("config.icons").diagnostics

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.INFO] = icons.Info,
      [vim.diagnostic.severity.HINT] = icons.Hint,
    },
  },
  virtual_text = false,
  virtual_lines = { current_line = true },
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})
