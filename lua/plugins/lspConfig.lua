return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Set global defaults for all LSP servers
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Configure Neovim's built-in diagnostic display
      vim.diagnostic.config({
        virtual_text = {
          -- Enable virtual text for diagnostics
          -- You can set this to false if you prefer not to see them directly in the text
          enable = true,
          -- Customize how virtual text looks
          -- You can adjust 'source' to show source of diagnostic
          -- Or 'prefix' for icons like "Error: " or "Warning: "
        },
        signs = true, -- Show signs in the sign column
        update_in_insert = false, -- Do not update diagnostics in insert mode
        severity_sort = true, -- Sort diagnostics by severity
        float = {
          -- Configure the floating window for diagnostics
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- lsp setups
      vim.lsp.enable('lua_ls')

      vim.lsp.config('pylsp', {
        cmd = { 'pylsp' },
        filetypes = { 'python' },
        settings = {
          pylsp = {
            plugins = {
              jedi_completion = {
                include_params = true,
              },
              -- Enable semantic tokens for better highlighting if supported by your pylsp version
              pylsp_jedi = {
                enabled = true,
              },
            },
          },
        },
      })

      vim.lsp.enable('pylsp')

      vim.lsp.enable('ts_ls')

      vim.lsp.config('clangd', {
        cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
        initialization_options = {
          fallback_flags = { '-std=c++17' },
        },
      })
      vim.lsp.enable('clangd')

      vim.lsp.enable('jdtls')
      vim.lsp.enable('gopls')

      vim.keymap.set('n', 'gi', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>cd', function() vim.diagnostic.open_float() end, { noremap = true, silent = true })
      -- Optional: Keymaps for navigating diagnostics
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

    end
  }
}

