return {


  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
      },
    }

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = 'p',
          play = '▶',
          step_into = '⏎',
          step_over = 'o',
          step_out = 'O',
          step_back = 'b',
          run_last = '▶▶',
          terminate = 't',
          disconnect = 'D',
        },
      },
    }


    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local dap = require('dap')
    dap.adapters.godot = {
        type = "server",
        host = '127.0.0.1',
        port = 6006,
    }
    dap.configurations.gdscript = {
        {
            type = "godot",
            request = "launch",
            name = "Launch Main scene",
            project = "${workspaceFolder}",
        },
    }
end,
}




