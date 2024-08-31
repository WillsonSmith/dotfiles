return {
  lazy = {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function(opts)
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_snipmate").load({ path = "./snippets" })
    end
  }
}
