vim.opt_local.spelllang = "en_us"
vim.opt_local.spell = true

local function set_softwrap()
  local o = vim.opt_local

  -- visual wrapping only
  o.wrap = true            -- show long lines wrapped
  o.linebreak = true       -- wrap at word boundaries
  o.breakindent = true     -- keep indentation on wrapped lines
  o.showbreak = "↪ "       -- prefix for wrapped screen lines (optional)
  o.list = false           -- avoid listchars clutter on wrapped lines

  -- ensure we DON'T insert hard linebreaks while typing
  o.textwidth = 0          -- never auto-wrap by width
  o.colorcolumn = ""       -- no column guide
  o.formatoptions:remove({ "t" }) -- don't auto-wrap comments/text

  -- move by visual lines when wrapped
  -- local mapopts = { buffer = ev.buf, silent = true }
  vim.keymap.set("n", "j", "gj")
  vim.keymap.set("n", "k", "gk")
  -- optional extras:
  vim.keymap.set("n", "0", "g0")
  vim.keymap.set("n", "$", "g$")
end

local function markdown_root_dir(_)
  local cwd = vim.loop.cwd()
  if cwd ~= nil then 
    local md_files = vim.fn.globpath(cwd, "*.md", false, true)

    if #md_files > 0 then
      return cwd
    end
  end


  return nil -- no root if no markdown files in cwd
end



set_softwrap()
if vim.fn.executable("marksman") == 1 then
  vim.lsp.start {
    name = "markdown",
    cmd = { "marksman" },
    root_dir = markdown_root_dir(),
  }
end


