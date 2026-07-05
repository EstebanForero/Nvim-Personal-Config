local parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "go",
  "html",
  "java",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "nix",
  "python",
  "query",
  "regex",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    build = function()
      if vim.fn.executable("tree-sitter") == 1 then
        vim.cmd.TSUpdate()
      end
    end,
    config = function()
      local function install_parsers()
        if vim.fn.executable("tree-sitter") == 1 then
          require("nvim-treesitter").install(parsers)
        end
      end

      if vim.fn.executable("tree-sitter") == 1 then
        install_parsers()
      else
        vim.api.nvim_create_autocmd("User", {
          pattern = "MasonToolsUpdateCompleted",
          once = true,
          callback = install_parsers,
        })
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("esteban-treesitter", { clear = true }),
        callback = function(event)
          pcall(vim.treesitter.start, event.buf)
        end,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
