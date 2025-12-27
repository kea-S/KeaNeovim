local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Retrieve the OpenAI API key from pass and trim any trailing whitespace/newlines
local openai_key = vim.fn.system("pass show APIs/personal/openai"):gsub("%s+$", "")
local anthropic_key = vim.fn.system("pass show APIs/personal/anthropic"):gsub("%s+$", "")
local gemini_key = vim.fn.system("pass show APIs/personal/gemini"):gsub("%s+$", "")
-- Set it as an environment variable that Avante can read (if it uses OPENAI_API_KEY)
vim.env.OPENAI_API_KEY = openai_key
vim.env.ANTHROPIC_API_KEY = anthropic_key
vim.env.GEMINI_API_KEY = gemini_key

require("vimConfig")
require("vimTerminal")
require("startup")
require("lazy").setup("plugins")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
