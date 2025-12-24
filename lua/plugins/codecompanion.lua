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
        adapter = "openai",
        split_size = "80c",
      },
      inline = {
        adapter = "openai",
      },
      cmd = {
        adapter = "openai",
      },
    },
    adapters = {
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = vim.env.OPENAI_API_KEY,
          },
          schema = {
            model = {
              -- gpt-5.2 is the flagship thinking model
              -- Use "gpt-5.2-chat-latest" if you want the faster 'Instant' version
              default = "gpt-5.2-chat-latest",
            },
            -- This enables the new xhigh reasoning for December 2025
            reasoning_effort = {
              default = "medium", -- Options: low, medium, high, xhigh
            },
          }
        })
      end,
    }, {
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
