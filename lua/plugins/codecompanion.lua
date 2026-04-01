return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  opts = {
    adapters = {
      acp = {
        codex = function()
          return require("codecompanion.adapters").extend("codex", {
            defaults = {
              auth_method = "openai-api-key", -- "openai-api-key"|"codex-api-key"|"chatgpt"
            },
            env = {
              OPENAI_API_KEY = "OPENAI_API_KEY"
            },
          })
        end,
      }
    },
    interactions = {
      chat = {
        adapter = {
          -- name = "gemini",
          -- model = "gemini-3-flash-preview",
          name = "codex",
        },
        split_size = "80c",
      },
      inline = {
        adapter = "gemini",
      },
      cmd = {
        adapter = "gemini",
      },
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

    vim.cmd([[cab cc CodeCompanion]])
  end,
}
