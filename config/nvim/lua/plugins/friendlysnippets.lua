return {
  {
    "L3MON4D3/LuaSnip",
    build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "benfowler/telescope-luasnip.nvim",
    },
    config = function(_, opts)
      if opts then
        require("luasnip").config.setup(opts)
      end
      vim.tbl_map(function(type)
        require("luasnip.loaders.from_" .. type).lazy_load()
      end, { "vscode", "snipmate", "lua" })
      -- friendly-snippets - enable standardized comments snippets
      require("luasnip").filetype_extend("lua", { "luadoc" })
      require("luasnip").filetype_extend("python", { "pydoc" })
      require("luasnip").filetype_extend("sh", { "shelldoc" })
    end,
  },
}
