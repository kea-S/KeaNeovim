return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "gemini",
        split_size = "80c",
      },
      inline = {
        adapter = "gemini",
      },
      cmd = {
        adapter = "gemini",
      },
    },
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = vim.env.GEMINI_KEY,
          },
          schema = {
            model = {
              default = "gemini-2.5-flash",
            },
          },
        })
      end,
    }, {
      claude = function()
        return require("codecompanion.adapters").extend("claude", {
          env = {
            api_key = vim.env.ANTHROPIC_API_KEY,
          },
          schema = {
            model = {
              default = "claude-opus-4",
            },
          },
        })
      end,
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_tools = true,
          show_server_tools_in_chat = true,
          add_mcp_prefix_to_tool_names = true,
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true
        }
      },

    }
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)
    -- Your keymaps are here
    vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
