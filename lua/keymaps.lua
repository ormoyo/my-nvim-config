-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

local create_keybind = vim.keymap.set
create_keybind({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
create_keybind('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
create_keybind('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
create_keybind('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
create_keybind('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
create_keybind('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
create_keybind('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
create_keybind('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat file' })
create_keybind('n', 'co', '<cmd>CompilerOpen<cr>', { desc = '[C]ompiler [O]pen' })
create_keybind('n', 'cs', '<cmd>CompilerStop<cr>', { desc = '[C]ompiler [S]top' })
create_keybind('n', 'cr', '<cmd>CompilerRedo<cr>', { desc = '[C]ompiler [R]edo' })
create_keybind('n', 'ct', '<cmd>CompilerToggleResults<cr>', { desc = '[C]ompiler [T]oggle' })

create_keybind('i', 'jj', function ()
  vim.cmd("stopinsert")
end, { desc = 'Exit insert' })
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--  callback = function()
--    vim.highlight.on_yank()
--  end,
--  group = highlight_group,
--  pattern = '*',
-- })


-- vim: ts=2 sts=2 sw=2 et
