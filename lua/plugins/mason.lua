return {
  {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "onsails/lspkind-nvim",
    config = function() require("mason").setup() end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      local mason_lspconfig = require "mason-lspconfig"
      local lspconfig = require "lspconfig"

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup()

      mason_lspconfig.setup_handlers {
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,
        ["rust_analyzer"] = function() end,
      }
    end,
  },
}
