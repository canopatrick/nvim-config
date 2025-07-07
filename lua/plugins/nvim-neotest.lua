return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "marilari88/neotest-vitest",
    "adrigzr/neotest-mocha"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest"),
        require('neotest-mocha')({
          command = "npm test --",
          command_args = function(context)
            -- The context contains:
            --   results_path: The file that json results are written to
            --   test_name_pattern: The generated pattern for the test
            --   path: The path to the test file
            --
            -- It should return a string array of arguments
            --
            -- Not specifying 'command_args' will use the defaults below
            return {
              "--full-trace",
              "--reporter=json",
              "--reporter-options=output=" .. context.results_path,
              "--grep=" .. context.test_name_pattern,
              context.path,
            }
          end,
          env = { CI = true },
          cwd = function(_path)
            return vim.fn.getcwd()
          end,
        }),
      }
    })
  end,
  keys = {
    {
      "<leader>Tc",
      function()
        require("neotest").run.run()
      end,
      mode = { "n", "v" },
      desc = "Run closest test",
    },

    {
      "<leader>Tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      mode = { "n", "v" },
      desc = "Run tests in current file",
    },

    {
      "<leader>Too",
      function()
        require("neotest").output_panel.open()
      end,
      mode = { "n", "v" },
      desc = "Open output panel",
    },

    {
      "<leader>Toc",
      function()
        require("neotest").output_panel.open()
      end,
      mode = { "n", "v" },
      desc = "Close output panel",
    },

    {
      "<leader>Tos",
      function()
        require("neotest").summary.open()
      end,
      mode = { "n", "v" },
      desc = "Open summary panel",
    },
  },
}
