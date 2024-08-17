local fzfBuildCommand = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build";

local dependencies = {
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = fzfBuildCommand
  }
}

local telescope = {};


telescope.keymaps = function()
  local included = require("telescope.builtin");
  local keymaps = {
    {"<C-p>", included.find_files},
    {"<leader>ff", included.find_files},
    {"<leader>fg", included.live_grep},
    {"<leader>fb", included.buffers},
    {"<leader>fh", included.help_tags}
  }

  for _, keymap in pairs(keymaps) do
    local keystroke = keymap[1];
    local command = keymap[2];
    vim.keymap.set('n', keystroke, command, {});
  end
end

telescope.lazy = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = dependencies,
  config = function()
    telescope.keymaps();
  end
}

return telescope
