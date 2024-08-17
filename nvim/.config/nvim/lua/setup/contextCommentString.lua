return {
  lazy = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      local commentString = require("ts_context_commentstring")
      commentString.setup({
        enable_autocmd = false,
        languages = {
          styled = '/* %s */'
        }
      })
    end
  }
}
