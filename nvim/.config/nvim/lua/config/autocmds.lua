-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Transparency settings
-- Apply after colorscheme loads to make background transparent
local transparent = true

if transparent then
  local function apply_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    
    -- Enhanced bright colors for visibility with transparent background
    vim.api.nvim_set_hl(0, "Directory", { fg = "#82aaff", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "Title", { fg = "#82aaff", bold = true })
    vim.api.nvim_set_hl(0, "Special", { fg = "#c099ff" })
    vim.api.nvim_set_hl(0, "Identifier", { fg = "#86e1fc" })
  end

  -- Apply transparency on colorscheme change
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = apply_transparency,
    desc = "Apply transparency after colorscheme loads",
  })

  -- Apply immediately on startup (critical for opening files directly)
  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
      vim.schedule(apply_transparency)
      -- Apply again with delays to catch late colorscheme loads
      vim.defer_fn(apply_transparency, 50)
      vim.defer_fn(apply_transparency, 100)
      vim.defer_fn(apply_transparency, 200)
    end,
    desc = "Apply transparency on Vim startup",
  })

  -- Apply after UI enters (handles opening nvim without files)
  vim.api.nvim_create_autocmd("UIEnter", {
    pattern = "*",
    callback = function()
      vim.schedule(apply_transparency)
      vim.defer_fn(apply_transparency, 50)
    end,
    desc = "Apply transparency after UI loads",
  })

  -- Apply after Lazy.nvim finishes loading (CRITICAL for transparency)
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      apply_transparency()
      vim.defer_fn(apply_transparency, 10)
      vim.defer_fn(apply_transparency, 50)
      vim.defer_fn(apply_transparency, 100)
      vim.defer_fn(apply_transparency, 200)
    end,
    desc = "Apply transparency after Lazy.nvim loads",
  })

  -- Apply when buffers are displayed
  vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = apply_transparency,
    desc = "Apply transparency when buffer enters window",
  })

  -- Also apply right away
  apply_transparency()
  
  -- And schedule it to apply after everything loads with multiple delays
  vim.schedule(function()
    apply_transparency()
    vim.defer_fn(apply_transparency, 50)
    vim.defer_fn(apply_transparency, 100)
    vim.defer_fn(apply_transparency, 200)
    vim.defer_fn(apply_transparency, 300)
  end)
end
