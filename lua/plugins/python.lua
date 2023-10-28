return {

	-- env selector
	{
		"linux-cultist/venv-selector.nvim",
		cmd = "VenvSelect",
		opts = function(_, opts)
			if require("lazyvim.util").has("nvim-dap-python") then
				opts.dap_enabled = true
			end
			return vim.tbl_deep_extend("force", opts, {
				name = {
					"venv",
					".venv",
					"env",
					".env",
				},
			})
		end,
		keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
	},

	-- formatter
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			table.insert(opts.ensure_installed, "python-lsp-server")
			table.insert(opts.ensure_installed, "diagnostic-languageserver")
			table.insert(opts.ensure_installed, "black")
			table.insert(opts.ensure_installed, "mypy")
			table.insert(opts.ensure_installed, "pylint")
		end,
	},

	-- debugger
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
	},
}
