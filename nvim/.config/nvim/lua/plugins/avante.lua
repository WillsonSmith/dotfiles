vim.pack.add {
  {
    src = "https://github.com/yetone/avante.nvim",
    name = "avante",
  },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",


  -- optionals
  "https://github.com/zbirenbaum/copilot.lua",
}

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    if event.data.kind == "install" and event.data.spec.name == "avante" then
      local path = event.data.path
      -- This callback isn't triggering as expected; investigate event conditions or debug the execution flow.
      vim.fn.system({ "make" }, path)
    end
  end,
})

require("copilot").setup {}

require("avante").setup {
  -- provider = "ollama",
  provider = "copilot",
  -- provider = "gemini",
  providers = {
    ollama = {
      endpoint = "http://localhost:11434",
      model = "qwen3-coder"
    },
  }
}
