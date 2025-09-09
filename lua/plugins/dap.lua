return {
  "mfussenegger/nvim-dap",
  recommended = true,
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mxsdev/nvim-dap-vscode-js",
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>dn", ":DapNew<cr>",                                                                        desc = "New Session" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
    { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
    {
      "<leader>dT",
      function()
        require("dap").terminate({ all = true })
        vim.notify("All DAP sessions terminated", vim.log.levels.INFO)
      end,
      desc = "Terminate All"
    },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    -- load mason-nvim-dap here, after all adapters have been setup
    if LazyVim.has("mason-nvim-dap.nvim") then
      require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    end

    require("dap-vscode-js").setup({
      node_path = "node",                                                 -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      debugger_path = "/Users/patrick/.local/share/nvim/vscode-js-debug", -- Path to vscode-js-debug installation.
      log_file_path = "/Users/patrick/.local/share/nvim/dap.log"
    })

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- print vim.fn.getcwd()
    for _, adapter in pairs({ "pwa-node", "pwa-chrome" }) do
      require("dap").adapters[adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        cwd = vim.fn.getcwd(),
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }
    end

    for name, sign in pairs(LazyVim.config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- setup dap config by VsCode launch.json file
    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    vscode.json_decode = function(str)
      local launch_config = vim.json.decode(json.json_strip_comments(str))
      if launch_config and launch_config.configurations then
        for _, config in ipairs(launch_config.configurations) do
          config.cwd = vim.fn.getcwd()
        end
      end
      return launch_config
    end

    -- local function patch_cwd(config)
    --   config.cwd = vim.fn.getcwd()
    -- end
    --
    -- local dap = require("dap")
    -- local old_load_launchjs = vscode.load_launchjs
    --
    -- vscode.load_launchjs = function(...)
    --   old_load_launchjs(...)
    --   for _, configs in pairs(dap.configurations) do
    --     for _, config in ipairs(configs) do
    --       patch_cwd(config)
    --     end
    --   end
    -- end
    --
    -- dap.listeners.before['event_initialized']['print_cwd'] = function(session, body)
    --   local config = session.config or {}
    --   print("DAP cwd:", config.cwd)
    -- end
  end,
}


-- return {
--   "mxsdev/nvim-dap-vscode-js",
--   config = function()
--     require("dap-vscode-js").setup({
--       -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
--       debugger_path = "(runtimedir)/vscode-js-debug", -- Path to vscode-js-debug installation.
--       -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
--       adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
--       -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
--       -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
--       -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
--     })
--     for _, language in ipairs({ "typescript", "javascript" }) do
--       require("dap").configurations[language] = {
--         {
--           type = "pwa-node",
--           request = "attach",
--           name = "Attach",
--           processId = require'dap.utils'.pick_process,
--           cwd = "${workspaceFolder}",
--         },
--       }
--     end
--   end,
-- }
