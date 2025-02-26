vim.cmd([[
augroup startup
autocmd VimEnter * :tab all

autocmd VimEnter * :10sp | ter 
autocmd VimEnter * :set winfixwidth
autocmd VimEnter * :set winfixheight

autocmd VimEnter * wincmd w
autocmd VimEnter * :set cc=80

augroup END
]])

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argv(0) == "" then
      require("telescope.builtin").find_files()
    end
  end,
})
