return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = false,
    build = function()
      require("blink.cmp").build():pwait()
    end,
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
      "echasnovski/mini.icons",
    },
    opts = function()
      local kind_icons = require("config.icons").kinds

      return {
        keymap = {
          preset = "none",
          ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<C-y>"] = { "select_and_accept" },
          ["<CR>"] = { "accept", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },
          ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
          ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
        },
        appearance = {
          nerd_font_variant = "mono",
          kind_icons = kind_icons,
        },
        completion = {
          accept = { auto_brackets = { enabled = true } },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 250,
            window = { border = "rounded" },
          },
          ghost_text = { enabled = true },
          list = { selection = { preselect = false, auto_insert = false } },
          menu = {
            border = "rounded",
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
              },
              components = {
                kind_icon = {
                  text = function(ctx)
                    return " " .. (kind_icons[ctx.kind] or kind_icons.Field) .. " "
                  end,
                },
              },
            },
          },
        },
        signature = {
          enabled = true,
          window = { border = "rounded" },
        },
        snippets = { preset = "default" },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      }
    end,
  },
}
