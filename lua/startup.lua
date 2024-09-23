vim.cmd([[
augroup startup
autocmd VimEnter * :tab all
autocmd VimEnter * :40vsp | ter 
autocmd VimEnter * wincmd w
augroup END
]])

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argv(0) == "" then
      require("telescope.builtin").find_files()
    end
  end,
})
