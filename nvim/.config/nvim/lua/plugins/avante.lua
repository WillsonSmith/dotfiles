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
  "https://github.com/nvim-telescope/telescope.nvim",
}

local function build_avante(path)
  local build_path = path .. "/build"
  if vim.fn.isdirectory(build_path) == 0 then
    vim.fn.system({ "make", "-C", path })
  end
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    if event.data.kind == "install" and event.data.spec.name == "avante" then
      vim.fn.system({ "make", "-C", event.data.path })
    end
  end,
})

local path = nil
for _, plugin in ipairs(vim.pack.get()) do
  if plugin.spec.name == "avante" then
    path = plugin.path
    break
  end
end

if path then
  build_avante(path)
else
  vim.notify("Avante plugin not found", vim.log.levels.ERROR)
end

require("copilot").setup {}

require("avante").setup {
  selector = {
    provider = "telescope"
  },
  provider = "ollama",
  -- provider = "lmstudio",
  -- provider = "copilot",
  -- provider = "gemini",
  providers = {
    gemini = {
      model = "gemini-2.0-flash"
    },
    ollama = {
      endpoint = "http://localhost:11434",
      model = "gpt-oss"
    },
    lmstudio = {
      __inherited_from = "openai",
      endpoint = "http://localhost:1234/v1",
      model = "qwen/qwen3-30b-a3b-2507",
      -- api_key_name = "LM_API_KEY",
    },
  }
}

