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
        ensure_installed = { "lua_ls", "pylsp", "tsserver", "clangd", "jdtls"}
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.pylsp.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {
          pylsp = {
            plugins = {
              jedi_completion = {
                include_params = true,
              },
            },
          },
        },
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        name = 'clangd',
        cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
        initialization_options = {
          fallback_flags = { '-std=c++17' },
        },
      })
      lspconfig.jdtls.setup({
        capabilities = capabilities,
      })

      vim.keymap.set('n', 'doc', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'def', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

    end
  }
}
