-- Snacks Explorer Color Configuration
-- Makes file names bright white and directories bold blue with transparent background
return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local function apply_explorer_colors()
        -- File and directory colors - bright white with transparent background
        vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = "#ffffff", bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { fg = "#82aaff", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#82aaff", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "Directory", { fg = "#82aaff", bg = "NONE", bold = true })
        
        -- Selection and cursor highlighting
        vim.api.nvim_set_hl(0, "SnacksPickerSelected", { bg = "#3d59a1", fg = "#ffffff", bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#2d3f76", fg = "#ffffff", bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#ffc777", bg = "NONE", bold = true, underline = true })
        
        -- Window styling - transparent
        vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "NONE", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = "#82aaff", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerInput", { fg = "#ffffff", bg = "NONE" })
        
        -- Git status colors
        vim.api.nvim_set_hl(0, "SnacksPickerGitStatusAdded", { fg = "#c3e88d", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified", { fg = "#ffc777", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerGitStatusDeleted", { fg = "#ff757f", bg = "NONE", bold = true })
        
        -- Transparent windows
        vim.api.nvim_set_hl(0, "FloatNormal", { bg = "NONE", fg = "#ffffff" })
      end

      -- Apply on colorscheme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = apply_explorer_colors,
        desc = "Apply Snacks explorer colors after colorscheme loads",
      })
      
      -- Apply on VimEnter to ensure it works when opening files directly
      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
          vim.schedule(apply_explorer_colors)
        end,
        desc = "Apply Snacks explorer colors on startup",
      })
      
      -- Apply immediately
      vim.schedule(apply_explorer_colors)
      
      return opts
    end,
  },
}
