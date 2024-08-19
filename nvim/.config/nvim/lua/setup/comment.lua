return {
  lazy = {
    "numtoStr/Comment.nvim",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true

      local comment = require("Comment")
      local integration = require("ts_context_commentstring.integrations.comment_nvim")
      comment.setup({
        pre_hook = integration.create_pre_hook(),
      })
    end,
    lazy = false;
  }
}
