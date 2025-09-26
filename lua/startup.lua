vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Apply general startup settings unconditionally
    vim.cmd("tab all")
    vim.cmd("set winfixwidth")
    vim.cmd("set winfixheight")
    vim.cmd("set cc=80")

    -- Conditional behavior based on Neovim startup arguments
    if vim.fn.argv(0) == "" then
      -- If no file is opened, start Telescope's file finder
      -- Use vim.defer_fn to ensure focus is correctly set after startup
      vim.defer_fn(function()
        require("telescope.builtin").find_files()
      end, 100) -- Small delay in milliseconds
    end
  end,
})

