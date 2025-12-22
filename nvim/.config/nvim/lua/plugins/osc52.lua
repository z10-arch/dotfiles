-- Use official ojroques/nvim-osc52 plugin for OSC52 clipboard over SSH/tmux
-- This integrates OSC52 as the default clipboard provider in Neovim via LazyVim

return {
  {
    "ojroques/nvim-osc52",
    lazy = false,
    opts = {
      max_length = 0, -- no limit
      silent = true,  -- don't echo on success
      trim = false,   -- keep whitespace
    },
    config = function(_, opts)
      local osc52 = require("osc52")
      -- enable verbose for now to help diagnose
      opts.silent = false
      osc52.setup(opts)

      -- Mirror yanks to system clipboard via OSC52 without overriding clipboard providers
      -- This avoids conflicts with other providers and works across SSH/tmux
      local group = vim.api.nvim_create_augroup("LazyOsc52", { clear = true })
      vim.api.nvim_create_autocmd("TextYankPost", {
        group = group,
        callback = function()
          if vim.v.event.operator ~= 'y' then return end
          -- log to help diagnose
          pcall(vim.notify, "[osc52] Yank detected -> sending via OSC52", vim.log.levels.INFO)
          -- Copy exactly the register that was yanked. If unnamed (""), use '"'.
          local reg = vim.v.event.regname ~= '' and vim.v.event.regname or '"'
          pcall(osc52.copy_register, reg)
        end,
        desc = "Send yanks over OSC52",
      })

      -- Ensure unnamed yanks go to + by default
      vim.opt.clipboard = "unnamedplus"
    end,
  },
}
