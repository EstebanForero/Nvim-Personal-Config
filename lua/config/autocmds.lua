local function group(name)
  return vim.api.nvim_create_augroup("esteban-" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group("yank-highlight"),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group("two-space-indent"),
  pattern = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "lua",
    "nix",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group("last-location"),
  callback = function(event)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lines = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = group("lsp-attach"),
  callback = require("config.keymaps.lsp").on_attach,
})
