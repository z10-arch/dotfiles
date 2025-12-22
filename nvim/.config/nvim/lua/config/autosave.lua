-- Minimal, controlled autosave (no plugins, no autowrite/autowriteall)
-- Saves only real file buffers that are modified and writable.
-- Events: InsertLeave, BufLeave, FocusLost
-- Safe for LSP (no format calls), refactors, and special buffers.

-- Ensure buffer-based workflows remain smooth
vim.opt.hidden = true

local augroup = vim.api.nvim_create_augroup("AutoSave", { clear = true })

-- Global toggle (default: on). Use :AutoSaveToggle to switch.
if vim.g.autosave_enabled == nil then
  vim.g.autosave_enabled = true
end

local function should_save(buf)
  -- Save any named, modified, writable buffer (more permissive)
  if not vim.bo[buf].modifiable or vim.bo[buf].readonly then
    return false
  end
  if not vim.bo[buf].modified then
    return false
  end
  local name = vim.api.nvim_buf_get_name(buf)
  if name == nil or name == "" then
    return false
  end
  return true
end

local function save_current()
  if not vim.g.autosave_enabled then
    return
  end
  -- Avoid saving while in insert mode for non-InsertLeave events
  local mode = vim.api.nvim_get_mode().mode
  if mode:sub(1, 1) == "i" then
    return
  end
  local buf = vim.api.nvim_get_current_buf()
  if should_save(buf) then
    -- Silent write; avoid triggering extra autocmds/formatters during autosave
    pcall(vim.cmd, "silent! noautocmd write")
  end
end

vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave", "FocusLost", "BufWinLeave" }, {
  group = augroup,
  callback = function()
    save_current()
  end,
})

-- On exit, ensure all eligible modified buffers are saved to avoid prompts
local function save_all()
  if not vim.g.autosave_enabled then
    return
  end
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and should_save(buf) then
      pcall(vim.api.nvim_buf_call, buf, function()
        pcall(vim.cmd, "silent! noautocmd write")
      end)
    end
  end
end

vim.api.nvim_create_autocmd({ "QuitPre", "VimLeavePre" }, {
  group = augroup,
  nested = true,
  callback = function()
    save_all()
  end,
})

vim.api.nvim_create_user_command("AutoSaveToggle", function()
  vim.g.autosave_enabled = not vim.g.autosave_enabled
  local state = vim.g.autosave_enabled and "enabled" or "disabled"
  vim.notify("AutoSave " .. state, vim.log.levels.INFO, { title = "AutoSave" })
end, { desc = "Toggle autosave on/off" })
