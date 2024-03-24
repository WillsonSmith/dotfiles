local toggle_terminal_config = {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require('toggleterm').setup({
      open_mapping = [[<c-\>]],
      insert_mappings = true,
    })

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",

      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,

      on_close = function()
        vim.cmd("startinsert!")
      end,
    })

    local function lazygit_toggle()
      lazygit:toggle()
    end

    vim.keymap.set('n', '<leader>g', lazygit_toggle)
  end
}

return toggle_terminal_config
