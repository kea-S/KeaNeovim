return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("mcphub").setup({
            cmd = "/run/current-system/sw/bin/bun",
            cmdArgs = {"/Users/keaharvan/.bun/bin/../install/global/node_modules/mcp-hub/dist/cli.js"}
        })
    end,
}
