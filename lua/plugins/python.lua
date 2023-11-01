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

	-- linting server
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.root_dir = opts.root_dir
				or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.formatting.black,
				nls.builtins.formatting.isort,
				nls.builtins.diagnostics.pylint,
				nls.builtins.diagnostics.mypy,
			})
		end,
	},
}
