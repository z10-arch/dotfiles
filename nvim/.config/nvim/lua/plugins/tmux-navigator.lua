-- Tmux + Neovim seamless navigation with hjkl
return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate Left (Tmux/Vim)" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate Down (Tmux/Vim)" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate Up (Tmux/Vim)" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate Right (Tmux/Vim)" },
      { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate Previous (Tmux/Vim)" },
    },
  },
}
