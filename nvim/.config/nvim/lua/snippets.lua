local snippets_by_filetype = {
  swift = {
    {
      trigger = "pub",
      body = "public ${0}"
    }
  }
}

local function get_buf_snippets()
  local ft = vim.bo.filetype
  local snips = vim.list_slice(global_snippets)

  if ft and snippets_by_filetype[ft] then
    vim.list_extend(snips, snippets_by_filetype[ft])
  end

  return snips
end
