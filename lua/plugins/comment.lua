return {
	"numToStr/Comment.nvim",
	keys = {
		-- Fast toggle for a single line or a visual selection
		{
			"<leader>/",
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			desc = "Comment line",
		},
		{
			"<leader>/",
			function()
				require("Comment.api").toggle.linewise(vim.fn.visualmode())
			end,
			mode = "x",
			desc = "Comment selection",
		},

		-- Simple block comment toggles (line + visual)
		{
			"<leader>cB",
			function()
				require("Comment.api").toggle.blockwise.current()
			end,
			desc = "Block comment line",
		},
		{
			"<leader>cB",
			function()
				require("Comment.api").toggle.blockwise(vim.fn.visualmode())
			end,
			mode = "x",
			desc = "Block comment selection",
		},
	},
	config = function()
		require("Comment").setup()
	end,
}
