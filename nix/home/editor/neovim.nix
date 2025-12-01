{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = [
      pkgs.vimPlugins.lazy-nvim
      pkgs.vimPlugins.which-key-nvim
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.neo-tree-nvim
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.nui-nvim
      pkgs.vimPlugins.dashboard-nvim
      pkgs.vimPlugins.tokyonight-nvim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-buffer
      pkgs.vimPlugins.cmp-path
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.nvim-surround
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.indent-blankline-nvim
      pkgs.vimPlugins.noice-nvim
      pkgs.vimPlugins.nvim-notify
      pkgs.vimPlugins.flash-nvim
      pkgs.ruff
    ];

    extraLuaConfig =
      with pkgs.vimPlugins;
      # lua
      ''
        -- Leader key
        vim.g.mapleader = " "

        -- Basic options
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.expandtab = true
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.clipboard = "unnamedplus"

        -- Set filetype for .envrc files (direnv)
        vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
          pattern = ".envrc",
          callback = function()
            vim.bo.filetype = "bash"
          end,
        })

        -- Set colorscheme first
        vim.cmd.colorscheme("tokyonight")

        -- Enable transparency
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

        -- Additional transparency for UI components
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "none" })

        require("lazy").setup({
          rocks = { enabled = false },
          pkg = { enabled = false },
          install = { missing = false },
          change_detection = { enabled = false },
          spec = {
            {
              dir = "${which-key-nvim}",
              name = "which-key.nvim",
              event = "VeryLazy",
              config = function()
                require("which-key").setup({
                  preset = "helix",
                  spec = {
                    { "<leader>f", group = "Find" },
                    { "<leader>s", group = "Search" },
                  }
                })
              end,
            },
            {
              dir = "${telescope-nvim}",
              name = "telescope.nvim",
              dependencies = {
                { dir = "${plenary-nvim}", name = "plenary.nvim" },
              },
              cmd = "Telescope",
              keys = {
                { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
                { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer Search" },
                { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
                { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
                { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
                { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find Word" },
                { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep Search" },
              },
              config = function()
                require("telescope").setup({})
              end,
            },
            {
              dir = "${neo-tree-nvim}",
              name = "neo-tree.nvim",
              branch = "v3.x",
              cmd = "Neotree",
              keys = {
                { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
              },
              dependencies = {
                { dir = "${nvim-web-devicons}", name = "nvim-web-devicons" },
                { dir = "${nui-nvim}", name = "nui.nvim" },
              },
              config = function()
                require("neo-tree").setup({
                  window = {
                    position = "right",
                    width = 30,
                  },
                  popup_border_style = "rounded",
                })
              end,
            },
            {
              dir = "${dashboard-nvim}",
              name = "dashboard-nvim",
              event = "VimEnter",
              config = function()
                local db = require("dashboard")
                db.setup({
                  theme = "doom",
                  config = {
                    header = {
                      "",
                      " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                      " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                      " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                      " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                      " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                      " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
                      "",
                    },
                    center = {
                      {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Find File",
                        desc_hl = "String",
                        key = "f",
                        action = "Telescope find_files",
                      },
                      {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Recent Files",
                        desc_hl = "String",
                        key = "r",
                        action = "Telescope oldfiles",
                      },
                      {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Grep Search",
                        desc_hl = "String",
                        key = "g",
                        action = "Telescope live_grep",
                      },
                      {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Quit",
                        desc_hl = "String",
                        key = "q",
                        action = "qa",
                      },
                    },
                    footer = {},
                  },
                })
                vim.api.nvim_set_hl(0, "DashboardHeader", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "DashboardCenter", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "DashboardFooter", { bg = "NONE" })

                -- Set 'q' to quit only for dashboard buffers
                vim.api.nvim_create_autocmd("FileType", {
                  pattern = "dashboard",
                  callback = function()
                    vim.keymap.set("n", "q", "<cmd>qa<cr>", { buffer = true, noremap = true, silent = true })
                  end,
                })
              end,
            },
            {
              dir = "${tokyonight-nvim}",
              name = "tokyonight.nvim",
              lazy = false,
              priority = 1000,
              config = function()
                require("tokyonight").setup({
                  style = "moon",
                  transparent = true,
                })
              end,
            },
            {
              dir = "${nvim-cmp}",
              name = "nvim-cmp",
              event = "InsertEnter",
              dependencies = {
                { dir = "${cmp-nvim-lsp}", name = "cmp-nvim-lsp" },
                { dir = "${cmp-buffer}", name = "cmp-buffer" },
                { dir = "${cmp-path}", name = "cmp-path" },
              },
              config = function()
                local cmp = require("cmp")
                cmp.setup({
                  sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                  }),
                  mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                  }),
                  snippet = {
                    expand = function(args)
                      vim.snippet.expand(args.body)
                    end,
                  },
                })
              end,
            },
            {
              dir = "${nvim-lspconfig}",
              name = "nvim-lspconfig",
              event = { "BufReadPre", "BufNewFile" },
              config = function()
                local lspconfig = require("lspconfig")
                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                -- Python type checking with pyright
                lspconfig.pyright.setup({
                  capabilities = capabilities,
                })

                -- Python linting with ruff
                lspconfig.ruff.setup({
                  capabilities = capabilities,
                })

                -- Basic keymaps for LSP
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true })
              end,
            },
            {
              dir = "${nvim-treesitter}",
              name = "nvim-treesitter",
              build = ":TSUpdate",
              event = { "BufReadPre", "BufNewFile" },
              config = function()
                require("nvim-treesitter.configs").setup({
                  auto_install = false,
                  highlight = {
                    enable = true,
                  },
                  indent = {
                    enable = true,
                  },
                })
              end,
            },
            {
              dir = "${nvim-surround}",
              name = "nvim-surround",
              event = "VeryLazy",
              config = function()
                require("nvim-surround").setup({})
              end,
            },
            {
              dir = "${lualine-nvim}",
              name = "lualine.nvim",
              event = "VeryLazy",
              config = function()
                require("lualine").setup({
                  options = {
                    theme = "tokyonight",
                  },
                })
              end,
            },
            {
              dir = "${indent-blankline-nvim}",
              name = "indent-blankline.nvim",
              event = { "BufReadPre", "BufNewFile" },
              config = function()
                require("ibl").setup()
              end,
            },
            {
              dir = "${nvim-notify}",
              name = "nvim-notify",
              event = "VeryLazy",
              config = function()
                require("notify").setup({
                  background_colour = "#000000",
                  opacity = 50,
                })
                vim.notify = require("notify")
              end,
            },
            {
              dir = "${noice-nvim}",
              name = "noice.nvim",
              event = "VeryLazy",
              dependencies = {
                { dir = "${nvim-notify}", name = "nvim-notify" },
              },
              config = function()
                require("noice").setup({
                  lsp = {
                    override = {
                      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                      ["vim.lsp.util.stylize_markdown"] = true,
                      ["cmp.entry.get_documentation"] = true,
                    },
                  },
                })
              end,
            },
            {
              dir = "${flash-nvim}",
              name = "flash.nvim",
              event = "VeryLazy",
              keys = {
                { "s", function() require("flash").jump() end, desc = "Flash", mode = { "n", "x", "o" } },
                { "S", function() require("flash").treesitter() end, desc = "Flash Treesitter", mode = { "n", "o", "x" } },
                { "r", function() require("flash").remote() end, desc = "Remote Flash", mode = "o" },
                { "R", function() require("flash").treesitter_search() end, desc = "Treesitter Search", mode = { "o", "x" } },
                { "<c-s>", function() require("flash").toggle() end, desc = "Toggle Flash Search", mode = { "c" } },
              },
              config = function()
                require("flash").setup({
                  labels = "asdfghjklqwertyuiopzxcvbnm",
                  search = {
                    multi_window = true,
                    forward = true,
                    wrap = true,
                  },
                  label = {
                    uppercase = false,
                    after = { 0, 0 },
                    before = { 0, 0 },
                    style = "overlay",
                  },
                  highlight = {
                    backdrop = true,
                  },
                  modes = {
                    search = {
                      enabled = true,
                    },
                    char = {
                      enabled = false,
                    },
                  },
                })
              end,
            },
          },
        })
      '';
  };
}
