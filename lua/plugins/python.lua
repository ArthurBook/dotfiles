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
    {
      "neovim/nvim-lspconfig",
      -- other settings removed for brevity
      opts = {
        ---@type lspconfig.options
        servers = {
          eslint = {
            settings = {
              -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
              workingDirectory = { mode = "auto" },
            },
          },
        },
        setup = {
          eslint = function()
            local function get_client(buf)
              return require("lazyvim.util").lsp.get_clients({ name = "eslint", bufnr = buf })[1]
            end

            local formatter = require("lazyvim.util").lsp.formatter({
              name = "eslint: lsp",
              primary = false,
              priority = 200,
              filter = "eslint",
            })

            -- Use EslintFixAll on Neovim < 0.10.0
            if not pcall(require, "vim.lsp._dynamic") then
              formatter.name = "eslint: EslintFixAll"
              formatter.sources = function(buf)
                local client = get_client(buf)
                return client and { "eslint" } or {}
              end
              formatter.format = function(buf)
                local client = get_client(buf)
                if client then
                  local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                  if #diag > 0 then
                    vim.cmd("EslintFixAll")
                  end
                end
              end
            end

            -- register the formatter with LazyVim
            require("lazyvim.util").format.register(formatter)
          end,
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
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
