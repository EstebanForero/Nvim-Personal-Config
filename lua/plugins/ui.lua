local palette = {
  bg = "#161616",
  surface = "#262626",
  surface_alt = "#393939",
  muted = "#525252",
  fg = "#f2f4f8",
  subdued = "#dde1e6",
  blue = "#78a9ff",
  cyan = "#3ddbd9",
  green = "#42be65",
  pink = "#ee5396",
  purple = "#be95ff",
  red = "#ff7eb6",
}

return {
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1100,
    config = function()
      vim.opt.background = "dark"
      vim.cmd.colorscheme("oxocarbon")

      local overrides = {
        Normal = { fg = palette.fg, bg = "none" },
        NormalNC = { fg = palette.subdued, bg = "none" },
        EndOfBuffer = { fg = palette.bg, bg = "none" },
        FoldColumn = { fg = palette.muted, bg = "none" },
        SignColumn = { fg = palette.subdued, bg = "none" },
        FloatBorder = { fg = palette.muted, bg = palette.bg },
        NormalFloat = { bg = palette.bg },
        Pmenu = { bg = palette.surface, fg = palette.fg },
        PmenuSel = { bg = palette.surface_alt, fg = palette.fg, bold = true },
        WinSeparator = { fg = palette.surface_alt },
        BlinkCmpMenu = { bg = palette.surface, fg = palette.fg },
        BlinkCmpMenuBorder = { fg = palette.muted, bg = palette.surface },
        BlinkCmpMenuSelection = { bg = palette.surface_alt, fg = palette.fg, bold = true },
        BlinkCmpKindFunction = { fg = palette.blue },
        BlinkCmpKindMethod = { fg = palette.blue },
        BlinkCmpKindVariable = { fg = palette.cyan },
        BlinkCmpKindClass = { fg = palette.purple },
        BlinkCmpKindInterface = { fg = palette.purple },
        BlinkCmpKindSnippet = { fg = palette.green },
        BlinkCmpKindKeyword = { fg = palette.pink },
      }
      for name, value in pairs(overrides) do
        vim.api.nvim_set_hl(0, name, value)
      end
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = { style = "glyph" },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
 ███╗   ██╗██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██║   ██║██║████╗ ████║
 ██╔██╗ ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          keys = {
            { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New file", action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "g", desc = "Find text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      explorer = { enabled = true },
      indent = {
        enabled = true,
        animate = { enabled = false },
        scope = { enabled = true },
      },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      picker = {
        enabled = true,
        ui_select = true,
        layout = { preset = "ivy" },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Find text" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Help pages" },
      { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>fc", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>fn", function() Snacks.picker.notifications() end, desc = "Notification history" },
      { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git branches" },
      { "<leader>gl", function() Snacks.lazygit() end, desc = "LazyGit" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
      { "<leader>z", function() Snacks.zen() end, desc = "Zen mode" },
      { "<C-`>", function() Snacks.terminal() end, desc = "Toggle terminal" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          vim.print = _G.dd
        end,
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 250,
      icons = { mappings = true },
      spec = {
        { "<leader>b", group = "buffers" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>m", group = "marks" },
        { "<leader>q", group = "quit/session" },
        { "<leader>u", group = "ui toggles" },
        { "<leader>w", group = "write/window" },
        { "<leader>x", group = "diagnostics" },
      },
      win = { border = "rounded" },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer keymaps",
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = { focus = true },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false win.position=right<cr>", desc = "Document symbols" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP locations" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
      { "[q", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Previous trouble item" },
      { "]q", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next trouble item" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    opts = function()
      local theme = {
        normal = {
          a = { fg = palette.bg, bg = palette.blue, gui = "bold" },
          b = { fg = palette.fg, bg = palette.surface_alt },
          c = { fg = palette.subdued, bg = palette.surface },
        },
        insert = { a = { fg = palette.bg, bg = palette.green, gui = "bold" } },
        visual = { a = { fg = palette.bg, bg = palette.purple, gui = "bold" } },
        replace = { a = { fg = palette.bg, bg = palette.red, gui = "bold" } },
        command = { a = { fg = palette.bg, bg = palette.pink, gui = "bold" } },
        inactive = { c = { fg = palette.muted, bg = palette.bg } },
      }
      return {
        options = {
          theme = theme,
          globalstatus = true,
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", icon = "" } },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1, symbols = { modified = " ●", readonly = " " } } },
          lualine_x = {
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return "" end
                return "  " .. table.concat(vim.tbl_map(function(client) return client.name end, clients), ", ")
              end,
            },
            "diagnostics",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "lazy", "mason", "quickfix" },
      }
    end,
  },
}
