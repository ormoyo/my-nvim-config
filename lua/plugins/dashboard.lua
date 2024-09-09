return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'doom',
      disable_move = true,
      config = {
        header = require('ascii').art.text.neovim.sharp, --your header
        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'New File                                           ',
            desc_hl = 'String',
            key = 'e',
            key_hl = 'Number',
            key_format = ' %s',
            action = "lua vim.ui.input({ prompt = 'File: '}, function(input) if input ~= null and input ~= '' then vim.cmd.edit(input) end end)",
          },
          {
            icon = '󰈞 ',
            icon_hl = 'Title',
            desc = 'Find Files',
            desc_hl = 'String',
            key = 'f',
            key_hl = 'Number',
            key_format = ' %s',
            action = 'Telescope find_files',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Browse Files',
            desc_hl = 'String',
            key = 'b',
            key_hl = 'Number',
            key_format = ' %s',
            action = 'Telescope file_browser',
          },
          {
            icon = '󰤘 ',
            icon_hl = 'Title',
            desc = 'Recent Files',
            desc_hl = 'String',
            key = 'r',
            key_hl = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'Telescope oldfiles'
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Projects',
            desc_hl = 'String',
            key = 'p',
            key_hl = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'Telescope projects'
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Plugins',
            desc_hl = 'String',
            key = 'l',
            key_hl = 'Number',
            key_format = ' %s',
            action = 'Lazy'
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Quit',
            desc_hl = 'String',
            key = 'q',
            key_hl = 'Number',
            key_format = ' %s',
            action = 'qa'
          },
        },
        footer = {} --your footer
      },
    }
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      "MaximilianLloyd/ascii.nvim",
      dependencies = { 'MunifTanjim/nui.nvim' },
    }
  }
}
