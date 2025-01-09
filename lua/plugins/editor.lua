return {
  "numToStr/Comment.nvim",
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "nvimdev/indentmini.nvim",
    config = function() require("indentmini").setup() end,
  },
}
