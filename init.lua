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

local function get_config_key(pass_path, prompt)
  local result = vim.fn.system("pass show " .. pass_path .. " 2>/dev/null"):gsub("%s+$", "")

  if vim.v.shell_error ~= 0 or result == "" then
    vim.api.nvim_echo({ { "\nKey not found in pass for: " .. pass_path, "WarningMsg" } }, true, {})
    result = vim.fn.inputsecret(prompt .. ": ")
  end
  return result
end

-- Retrieve the keys or prompt if missing
-- local openai_key = get_config_key("APIs/personal/openai", "Enter OpenAI API Key")
-- local anthropic_key = get_config_key("APIs/personal/anthropic", "Enter Anthropic API Key")
local gemini_key = get_config_key("APIs/personal/gemini", "Enter Gemini API Key")

-- Set it as an environment variable
-- vim.env.OPENAI_API_KEY = openai_key
-- vim.env.ANTHROPIC_API_KEY = anthropic_key
vim.env.GEMINI_API_KEY = gemini_key


require("vimConfig")
require("vimTerminal")
require("startup")
require("lazy").setup("plugins")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
