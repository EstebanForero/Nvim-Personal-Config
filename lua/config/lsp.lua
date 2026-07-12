local M = {}

-- Servers that are not managed by Mason and must be enabled explicitly.
-- Server-specific overrides belong in after/lsp/<server>.lua.
local manually_enabled_servers = {
  "gdscript",
}

function M.setup()
  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  vim.lsp.enable(manually_enabled_servers)
end

return M
