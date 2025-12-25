-- if vim.fn.executable("sourcekit-lsp") == 1 then
--   vim.lsp.start {
--     name = "Sourcekit",
--     cmd = { "sourcekit-lsp" },
--     root_dir = vim.fs.dirname(vim.fs.find({ "Package.swift" }, { upward = true })[1]),
--     settings = {
--       Swift = {
--         workspace = {
--           didChangeWatchedFiles = {
--             dynamicRegistration = true,
--           }
--         }
--       }
--     }
--   }
-- end

if vim.fn.executable("tsgo") == 1 then
  vim.lsp.start {
    name = "Typescript (native)",
    cmd = { "tsgo", "--lsp", "--stdio" },
    -- root_dir = vim.fs.dirname(vim.fs.find({ "package.json"}, {upward = true})[1])
  }
else
  print("tsgo not found")
end
