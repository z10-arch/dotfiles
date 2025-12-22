return {
  -- DAP (Debug Adapter Protocol) core
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")

          -- Setup dapui
          dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
            mappings = {
              expand = { "<CR>", "<2-LeftMouse>" },
              open = "o",
              remove = "d",
              edit = "e",
              repl = "r",
              toggle = "t",
            },
            layouts = {
              {
                elements = {
                  { id = "scopes", size = 0.25 },
                  { id = "breakpoints", size = 0.25 },
                  { id = "stacks", size = 0.25 },
                  { id = "watches", size = 0.25 },
                },
                size = 40,
                position = "left",
              },
              {
                elements = {
                  { id = "repl", size = 0.5 },
                  { id = "console", size = 0.5 },
                },
                size = 10,
                position = "bottom",
              },
            },
            floating = {
              max_height = nil,
              max_width = nil,
              border = "single",
              mappings = {
                close = { "q", "<Esc>" },
              },
            },
            windows = { indent = 1 },
            render = {
              max_type_length = nil,
              max_value_lines = 100,
            },
          })

          -- Automatically open/close dapui
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },

      -- Virtual text for DAP
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            filter_references_pattern = "<module",
            virt_text_pos = "eol",
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
          })
        end,
      },

      -- Mason integration for DAP
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason-org/mason.nvim" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {
            "python",
            "delve", -- Go debugger
            "js-debug-adapter", -- JavaScript/TypeScript
            "codelldb", -- C/C++/Rust
          },
        },
      },

      -- Python DAP
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
          -- Try to find debugpy in various locations
          local debugpy_path = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
          if vim.fn.filereadable(debugpy_path) == 0 then
            debugpy_path = vim.fn.exepath("python3") or vim.fn.exepath("python")
          end
          require("dap-python").setup(debugpy_path)
        end,
      },

      -- Go DAP
      {
        "leoluz/nvim-dap-go",
        ft = "go",
        config = function()
          require("dap-go").setup({
            dap_configurations = {
              {
                type = "go",
                name = "Attach remote",
                mode = "remote",
                request = "attach",
              },
            },
            delve = {
              path = "dlv",
              initialize_timeout_sec = 20,
              port = "${port}",
              args = {},
              build_flags = "",
            },
          })
        end,
      },
    },

    keys = {
      -- Basic debugging
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      
      -- DAP UI
      { "<leader>du", function() require("dapui").toggle() end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      
      -- Language specific
      { "<leader>dpt", function() require("dap-python").test_method() end, desc = "Debug Python Test Method", ft = "python" },
      { "<leader>dpc", function() require("dap-python").test_class() end, desc = "Debug Python Test Class", ft = "python" },
      { "<leader>dgt", function() require("dap-go").debug_test() end, desc = "Debug Go Test", ft = "go" },
      { "<leader>dgl", function() require("dap-go").debug_last_test() end, desc = "Debug Last Go Test", ft = "go" },
    },

    config = function()
      local dap = require("dap")

      -- DAP signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

      -- JavaScript/TypeScript configuration
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
          },
        }
      end

      -- Node.js adapter configuration
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- Chrome adapter configuration
      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- C/C++/Rust configuration with codelldb
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      for _, lang in ipairs({ "c", "cpp", "rust" }) do
        dap.configurations[lang] = {
          {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
        }
      end
    end,
  },
}
