return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'BurntSushi/ripgrep',
      build = 'cargo build --release',
    },
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
      'coffebar/project.nvim',
      dependencies = {
        'nvim-telescope/telescope.nvim',
        {
          'Shatur/neovim-session-manager',
          dependencies = { 'nvim-lua/plenary.nvim' },
        }
      },
      config = function()
        require('project_nvim').setup({
          require('telescope').load_extension('projects')
        })

        local Autoload = require('session_manager.config').AutoloadMode
        local mode = Autoload.Disabled
        local project_root, _ = require('project_nvim.project').get_project_root()
        if project_root ~= nil then
          mode = Autoload.CurrentDir
        end

        require('session_manager').setup({
          autoload_mode = mode,               -- Define what to do when Neovim is started without arguments.
          autosave_last_session = true,       -- Automatically save last session on exit and on session switch.
          autosave_ignore_not_normal = false, -- keep it false
          autosave_ignore_filetypes = {       -- All buffers of these file types will be closed before the session is saved.
            "ccc-ui",
            "gitcommit",
            "qf",
          },
          autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
        })

        -- local timer = vim.loop.new_timer()
        -- timer:start(2, 0, vim.schedule_wrap(function(_, _)
        --   local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {})
        --   vim.g.neovimsession_newfile = vim.fn.expand('%:p')
        --   vim.api.nvim_create_autocmd({ 'User' }, {
        --     pattern = "SessionLoadPost",
        --     group = config_group,
        --     callback = function()
        --       local timer = vim.loop.new_timer()
        --       if vim.g.neovimsession_newfile == nil or vim.g.neovimsession_newfile == '' then
        --         return;
        --       end
        --       vim.cmd('e ' .. vim.g.neovimsession_newfile)
        --     end,
        --   })
        -- end))

        -- -- Auto save session
        -- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        --   callback = function()
        --     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        --       -- Don't save while there's any 'nofile' buffer open.
        --       if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
        --         return
        --       end
        --     end
        --     require('session_manager').save_current_session()
        --   end
        -- })
      end,
    },
  }
}
