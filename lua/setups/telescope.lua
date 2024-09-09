-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = true,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

local create_keybind = vim.keymap.set
-- See `:help telescope.builtin`
create_keybind('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
create_keybind('n', '<leader><space>', function()
  require('telescope.builtin').buffers {
    attach_mappings = function(prompt_bufnr, map)
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local delete_buf = function()
        local selection = action_state.get_selected_entry()
        -- depending if you want to close or not, include this or not
        actions.close(prompt_bufnr)
        -- print(vim.inspect(selection))
        -- better print selection before first running this. I am not sure if it have a bufnr or if this field is named differently
        vim.api.nvim_buf_delete(selection.bufnr, { force = true })
      end

      -- mode, key, func
      -- this is just an example
      map('n', 'd', delete_buf)
      return true;
    end
  }
end, { desc = '[ ] Find existing buffers' })
create_keybind('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

create_keybind('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
create_keybind('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
create_keybind('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
create_keybind('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
create_keybind('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
create_keybind('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
create_keybind('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
create_keybind('n', '<leader>ss', require('telescope.builtin').resume, { desc = '[S]earch Previous [S]earch' })
-- create_keybind('n', '<leader>sp', require('telescope').extensions.projects.projects, { desc = '[S]earch [P]rojects' })
create_keybind('n', '<leader>sp', function()
  require('telescope').extensions.projects.projects {
    attach_mappings = function(prompt_bufnr, map)
      local action_state = require('telescope.actions.state')
      local add_tosession = function()
        local selection = action_state.get_selected_entry()
        vim.g.neovimsession_newfile = selection;
        -- print(vim.inspect(selection))
        -- better print selection before first running this. I am not sure if it have a bufnr or if this field is named differently
      end

      -- mode, key, func
      -- this is just an example
      --
      map('n', '<cr>', add_tosession)
      return true;
    end
  }
end, { desc = '[ ] Find existing buffers' })
create_keybind('n', '<leader>bf', require('telescope').extensions.file_browser.file_browser,
  { desc = '[S]earch [P]rojects' })

local load_extension = function(ext, keybind, desc)
  require('telescope').load_extension(ext)
  create_keybind('n', keybind, require('telescope').extensions[ext][ext],
    { desc = desc })
end
-- vim: ts=2 sts=2 sw=2 et
