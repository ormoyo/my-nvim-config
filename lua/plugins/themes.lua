return {
  {
    'projekt0n/github-nvim-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1100, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        -- ...
      })

      vim.cmd('colorscheme github_dark')
    end,
  },
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 900,
    config = function()
      require('onedark').setup({
        highlights = {
          ['@lsp.type.modifier'] = { fg = '#c678dd' },
          ['Type'] = { fg = '#c678dd' },
        },
      })

      require('onedark').load()
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        --...
      })

      vim.cmd('colorscheme tokyonight')
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        --...
      })

      vim.cmd('colorscheme catppuccin')
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        --...
      })

      vim.cmd('colorscheme tokyonight')
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
}
