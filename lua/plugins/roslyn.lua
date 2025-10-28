return {
  -- Why install this as a separate plugin and not through nvim-lsp?  Because this has some features not supported there yet
  -- namely source generated files.
  "seblyng/roslyn.nvim",
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    -- your configuration comes here; leave empty for default settings
  },
}
