local M = {}
-- Remove common leading indentation (spaces or tabs) from a multi-line string
function M.dedent(str)
  -- 1) Find minimum indent of any non-blank line
  local min_indent
  for line in str:gmatch("[^\n]+") do
    local indent = line:match("^([ \t]*)%S")  -- indent before first non-space
    if indent then
      if not min_indent or #indent < #min_indent then
        min_indent = indent
      end
    end
  end

  -- 2) If we found any indent, strip it; otherwise return string unchanged
  if min_indent and #min_indent > 0 then
    -- Escape tabs for pattern safety
    local patt = "\n" .. min_indent:gsub("\t", "\t")
    str = str:gsub("^" .. min_indent, "")   -- first line (if indented)
             :gsub(patt, "\n")              -- subsequent lines
  end
  return str
end

function M.map(tbl, fn)
  local result = {}
  for i, v in ipairs(tbl) do
    result[i] = fn(v, i)
  end
  return result
end

return M
