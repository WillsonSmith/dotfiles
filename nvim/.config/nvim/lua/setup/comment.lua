return {
  lazy = {
    "numtoStr/Comment.nvim",
    config = function()
      local comment = require("Comment")
      local integration = require("ts_context_commentstring.integrations.comment_nvim")
      -- comment.setup({
      --   pre_hook = integration.create_pre_hook(),
      -- })
    end,
    lazy = false;
  }
}
