return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "pass show APIs/personal/neovim/chatGPTNvim",
      openai_params = {
        model = "gpt-4o-mini",
        max_tokens = 600
       }
    })
    vim.keymap.set('n', '<leader>gpt', ':ChatGPT<CR>')
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
