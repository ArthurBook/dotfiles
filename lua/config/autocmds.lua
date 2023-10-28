-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- -- ... existing autocmds

vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Auto select virtualenv Nvim open",
	pattern = "*",
	callback = function()
		local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
		if venv ~= "" then
			require("venv-selector").retrieve_from_cache()
		end
	end,
	once = true,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("lspconfig").pylsp.setup({
			filetypes = { "python" },
			settings = {
				pylsp = require("lspconfig").pylsp, -- required to enable pylsp
				configurationSources = { "black", "pylint", "mypy" },
				formatCommand = { "black" },
			},
		})
	end,
})
