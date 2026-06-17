return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      interactions = {
        inline = { adapter = "copilot", model = "gpt-4.1-mini" },
        chat = { adapter = "copilot" },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cabbrev cc CodeCompanion]])
    end,
  },
}
