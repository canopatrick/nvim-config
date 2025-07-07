return {
  "olimorris/codecompanion.nvim",
  opts = {
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<Leader>CC", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Menu", },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          name = "copilot",
          model = "claude-sonnet-4-20250514"
        }
      },
      display = {
        chat = {
          show_settings = true,
        }
      }
    })
  end,
}
