return {
  lazy = {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(
            term.bufnr,
            "n",
            "q",
            "<cmd>close<CR>",
            { noremap = true, silent = true }
          )
        end,
        on_close = function()
          vim.cmd("startinsert!")
        end
      })

      vim.keymap.set("n", "<leader>g", function() lazygit:toggle() end)
    end
  }
}
