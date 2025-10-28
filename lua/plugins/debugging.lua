return {
  {
    -- Debug Framework
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    opts = {
      expand_lines = true,
      controls = { enabled = false }, -- no extra play/step buttons
      floating = { border = "rounded" },
      -- Set dapui window
      render = {
        max_type_length = 60,
        max_value_lines = 200,
      },
      -- Only one layout: just the "scopes" (variables) list at the bottom
      layouts = {
        {
          elements = {
            { id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
          },
          size = 15, -- height in lines (adjust to taste)
          position = "bottom", -- "left", "right", "top", "bottom"
        },
      },
    },
    keys = {
      {
        "<leader>dw",
        mode = { "n" },
        function()
          require("dapui").eval(nil, { enter = true })
        end,
        desc = "Add word under cursor to watches",
      },
    },
    config = function(_, opts)
      local dapui = require("dapui")
      local dap = require("dap")

      --- open ui immediately when debugging starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      vim.fn.sign_define("DapBreakpoint", {
        text = "⚪",
        texthl = "DapBreakpointSymbol",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      })

      vim.fn.sign_define("DapStopped", {
        text = "🔴",
        texthl = "yellow",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = "⭕",
        texthl = "DapStoppedSymbol",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      })
      dapui.setup(opts)
    end,
    event = "VeryLazy",
  },
  { "nvim-neotest/nvim-nio" },
  {
    -- UI for debugging
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap = require("dap")

      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"

      local netcoredbg_adapter = {
        type = "executable",
        command = mason_path,
        args = { "--interpreter=vscode" },
      }

      dap.adapters.netcoredbg = netcoredbg_adapter -- needed for normal debugging
      dap.adapters.coreclr = netcoredbg_adapter -- needed for unit test debugging

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return require("dap-dll-autopicker").build_dll_path()
          end,
        },
      }

      local map = vim.keymap.set

      local opts = { noremap = true, silent = true }

      map("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
      map("n", "<F6>", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", opts)
      map("n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
      map("n", "<Down>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
      map("n", "<Right>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
      map("n", "<Left>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
      -- map("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
      map("n", "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
      map("n", "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)
      map(
        "n",
        "<leader>td",
        "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
        { noremap = true, silent = true, desc = "debug nearest test" }
      )
    end,
  },
  {
    "nsidorenco/neotest-vstest",
    lazy = false,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        require("neotest-vstest"),
      },
    },
    keys = {
      {
        "<leader>tr",
        mode = { "n" },
        function()
          require("neotest").run.run()
        end,
        desc = "Runs the closest test",
      },
      {
        "<leader>ta",
        mode = { "n" },
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run all tests in the file",
      },
      {
        "<leader>tA",
        mode = { "n" },
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "Runs all unit tests in solution",
      },
      {
        "<leader>ts",
        mode = { "n" },
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggles the test summary window",
      },
      {
        "[n",
        mode = { "n" },
        function()
          require("neotest").jump.prev({ status = "failed" })
        end,
        desc = "Jumps to previous failed test",
      },
      {
        "]n",
        mode = { "n" },
        function()
          require("neotest").jump.next({ status = "failed" })
        end,
        desc = "Jumps to next failed test",
      },
    },
  },
  {
    "ramboe/ramboe-dotnet-utils",
    dependencies = { "mfussenegger/nvim-dap" },
  },
}
