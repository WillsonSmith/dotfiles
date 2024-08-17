local function initLazy()
  local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(path) then
    vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    })
  end

  vim.opt.rtp:prepend(path);
  vim.g.mapleader = " "
end

return {
  init = initLazy
}
