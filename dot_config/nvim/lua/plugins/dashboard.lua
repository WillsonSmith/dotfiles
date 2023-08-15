local dashboard_config = {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("dashboard").setup {}
  end
}

return dashboard_config

