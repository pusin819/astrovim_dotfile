return {
  {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "onsails/lspkind-nvim",
    config = function() require("mason").setup() end,
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
      }
    end,
  },
}
