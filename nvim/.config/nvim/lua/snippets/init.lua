local global_snippets = {}

local snippets_by_filetype = {
  swift = require("snippets.swift")
}

local function get_buf_snippets()
  local ft = vim.bo.filetype
  local snips = vim.list_slice(global_snippets)

  if ft and snippets_by_filetype[ft] then
    vim.list_extend(snips, snippets_by_filetype[ft])
  end

  return snips
end

local M = {}
function M.register_cmp_source()
  local cmp_source = {}
  local cache = {}

  function cmp_source.complete(_, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()
    if not cache[bufnr] then
      local completion_items = vim.tbl_map(function(s)
        --@type lsp.CompletionItem
        local item = {
          word = s.trigger,
          label = s.label or s.trigger,
          kind = vim.lsp.protocol.CompletionItemKind.Snippet,
          insertText = s.body,
          insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
        }
        return item
      end, get_buf_snippets())

      cache[bufnr] = completion_items
    end

    callback(cache[bufnr])
  end

  require("cmp").register_source("snp", cmp_source)
end

return M
