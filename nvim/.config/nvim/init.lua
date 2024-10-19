require("globals.preInit")
require("preferences")
require("plugins")
require("globals.generic")

local function display_tmux_popup_with_glow()
  -- Get the current file name
  local filename = vim.fn.expand("%:p")

  if filename == "" then
    local tmux_command = "tmux display-popup -E 'glow'"
    vim.fn.system(tmux_command)
  end

  if filename ~= "" then
    local tmux_command = "tmux display-popup -E 'glow \"" .. filename .. "\" --pager'"
    vim.fn.system(tmux_command)
  end
end

-- Bind the function to a key
vim.keymap.set("n", "<leader>gp", function() display_tmux_popup_with_glow() end, { noremap = true, silent = true })
