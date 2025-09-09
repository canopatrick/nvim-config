return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    -- Extend the existing vtsls configuration
    if not opts.servers then
      opts.servers = {}
    end

    opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, {
      settings = {
        typescript = {
          preferences = {
            includePackageJsonAutoImports = "on",
            includeCompletionsForModuleExports = true,
          }
        },
        javascript = {
          preferences = {
            includePackageJsonAutoImports = "on",
            includeCompletionsForModuleExports = true,
          }
        }
      }
    })

    return opts
  end,
}
