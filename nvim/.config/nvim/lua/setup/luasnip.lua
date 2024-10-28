-- List available snippets w/ :SnipList
local list_snips = function()
  local ft_list = require("luasnip").available()[vim.o.filetype]
  local ft_snips = {}
  for _, item in pairs(ft_list) do
    ft_snips[item.trigger] = item.name
  end
  print(vim.inspect(ft_snips))
end

vim.api.nvim_create_user_command("SnipList", list_snips, {})


-- Config
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
