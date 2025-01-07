return{
  {
		"xiyaowong/nvim-transparent",
	},
	{
	  "catppuccin/nvim",
	  name = "catppuccin",
	  priority = 1000,
	  config = function()
	    require("configs.catppuccin")
	  end,
	}
}
