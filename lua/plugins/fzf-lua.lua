return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  --dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "echasnovski/mini.icons" },
  opts = {},
  keys = {
    { 
      "<leader>ff",
      function() require('fzf-lua').files() end,
      desc = "[F]ind [F]iles"
    },
    { 
      "<leader>fr",
      function() require('fzf-lua').resume() end,
      desc = "[F]ind [R]esume"
    },
    { 
      "<leader>fg",
      function() require('fzf-lua').live_grep() end,
      desc = "[F]ind [G]rep"
    },
    { 
      "<leader>fc",
      function() require('fzf-lua').files({cwd=vim.fn.stdpath("config")}) end,
      desc = "[F]ind [C]onfig"
    },
    { 
      "<leader>fb",
      function() require('fzf-lua').builtin() end,
      desc = "[F]ind [B]uiltin fuzzy finders"
    },
    { 
      "<leader>fh",
      function() require('fzf-lua').helptags() end,
      desc = "[F]ind [H]elp"
    },
    { 
      "<leader>fk",
      function() require('fzf-lua').keymaps() end,
      desc = "[F]ind [K]eymaps"
    },
    { 
      "<leader>fw",
      function() require('fzf-lua').grep_cword() end,
      desc = "[F]ind current [W]ord"
    },
    { 
      "<leader>fW",
      function() require('fzf-lua').grep_cWORD() end,
      desc = "[F]ind current [W]ORD"
    },
    { 
      "<leader>,",
      function() require('fzf-lua').buffers() end,
      desc = "[,] Find existing buffers"
    },
    { 
      "<leader>/",
      function() require('fzf-lua').lgrep_curbuf() end,
      desc = "[/] Live grep the current buffer"
    },
    { 
      "<leader>gb",
      function() require('fzf-lua').git_branches() end,
      desc = "[F]ind [G]it branches"
    },
    -- TODO: https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#commands
  }
}
