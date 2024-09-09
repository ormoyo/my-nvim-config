require('mini.pairs').setup()
require('mini.move').setup({
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = '<C-M-Left>',
    right = '<C-M-Right>',
    down = '<C-M-Down>',
    up = '<C-M-Up>',

    -- Move current line in Normal mode
    line_left = '<C-M-Left>',
    line_right = '<C-M-Right>',
    line_down = '<C-M-Down>',
    line_up = '<C-M-Up>',
  },

  -- Options which control moving behavior
  options = {
    -- Automatically reindent selection during linewise vertical move
    reindent_linewise = true,
  },
})
require('mini.indentscope').setup()
require('mini.comment').setup()
require('mini.surround').setup()
require('mini.operators').setup()
