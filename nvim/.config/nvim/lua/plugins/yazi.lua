return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- Yazi with <leader>- (Space + minus)
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        desc = "Open Yazi (file manager)",
      },
      {
        "<leader>_",
        "<cmd>Yazi cwd<cr>",
        desc = "Open Yazi at cwd",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume last Yazi session",
      },
    },
    opts = {
      -- Don't open yazi for directories (keep traditional behavior)
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-x>",
        open_file_in_tab = "<c-t>",
        grep_in_directory = "<c-s>",
        replace_in_directory = "<c-g>",
        cycle_open_buffers = "<tab>",
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
      },
    },
  },
}
