return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
  dependencies = {
    "hrsh7th/cmp-cmdline", -- add cmp-cmdline as dependency of cmp
  },
  config = function(plugin, opts)
    local cmp = require "cmp"
    -- run cmp setup
    cmp.setup {
      completion = {
        completeopt = "menu,menuone,noinsert", -- "noselect"を除外した残り
      },
      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
      },
      window = {
        completion = cmp.config.window.bordered {
          border = "none",
          side_padding = 0,
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:CursorLine,Search:None",
        },
        documentation = cmp.config.window.bordered {
          border = "none",
          padding = 1,
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu",
        },
      },
      sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      },
      experimental = {
        ghost_text = true,
      },
    }

    -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
}
