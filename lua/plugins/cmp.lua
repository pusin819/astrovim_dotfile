return {
  {
    "hrsh7th/nvim-cmp",
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
    },
    config = function(plugin, opts)
      local cmp = require "cmp"
      -- run cmp setup
      cmp.setup {
        formatting = {
          format = require("lspkind").cmp_format {
            mode = "symbol", -- show only symbol annotations
            maxwidth = {
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50, -- leading text (labelDetails)
              abbr = 50, -- actual suggestion item
            },
            symbol_map = { Copilot = "" },
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            before = function(entry, vim_item)
              -- ...
              return vim_item
            end,
          },
        },
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
          { name = "copilot", priority = 1200 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        },
        experimental = {
          ghost_text = true,
        },
      }

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
  },
}
