return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      cs = { "csharpier" },
      typescript = { "eslint" },
    },
    formatters = {
      csharpier = {
        command = "csharpier",
        args = {
          "format",
          "--write-stdout",
        },
        to_stdin = true,
      },
      eslint = {
        command = "eslint",
        args = { "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
        to_stdin = true,
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
