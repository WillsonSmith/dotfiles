vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-telescope/telescope.nvim"
}


require("telescope").setup {
  pickers = {
    live_grep = {
      additional_args = { "--hidden" }
    },
    find_files = {
      find_command = { 'rg', '--files', '--iglob', '!{.git,.build}', '--hidden' },
      previewer = false,
      theme = "dropdown"
    },
    spell_suggest = {
      theme = "dropdown"
    }
  }
}

-- keymaps
local included = require("telescope.builtin")
local keymaps = {
  { "<C-p>",      included.find_files },
  { "<leader>ff", included.find_files },
  { "<leader>fg", included.live_grep },
  { "<leader>fb", included.buffers },
  { "<leader>fh", included.help_tags },
  { "<leader>ss", included.spell_suggest }
}

for _, keymap in pairs(keymaps) do
  local keystroke = keymap[1];
  local command = keymap[2];
  vim.keymap.set('n', keystroke, command, {});
end
