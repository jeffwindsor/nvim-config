--=============================================================================
-- Minimal NeoVim with Helix "feel"
-- UNFINISHED
--=============================================================================

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

--=============================================================================

-- mini functions for plugins
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- execute immediately
now(function()
  vim.g.mapleader = "<Space>"
  vim.o.termguicolors = true
  vim.cmd('colorscheme randomhue')

  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()

  require('mini.basics').setup()     -- Common configuration presets
  require('mini.icons').setup()      -- minimal icons
  require('mini.statusline').setup() -- status line
  require('mini.tabline').setup()    -- buffer line

  add({ source = 'okuuva/auto-save.nvim' })
  require('auto-save').setup()
  
end)

-- execute later
later(function()
  
  require('mini.ai').setup()         -- extend a/i textobjects
  require('mini.align').setup()      -- align text interactively
  require('mini.bracketed').setup()  -- go forward/backward with square brackets
  require('mini.comment').setup()    -- comment lines
  require('mini.completion').setup() -- completion and signature help
  require('mini.cursorword').setup() -- autohighlight word under cursor
  require('mini.indentscope').setup()
  -- require('mini.jump').setup()       -- fFtT work on multiple lines
  require('mini.jump2d').setup()     -- jump within visible lines via iterative labels
  -- require('mini.pairs').setup()      -- pair brackets
  require('mini.pick').setup()       -- pickers
  -- require('mini.splitjoin').setup()  -- split and join function arguments
  require('mini.surround').setup()   -- surround
  
  add({ source = 'mikavilpas/yazi.nvim', depends = { 'nvim-lua/plenary.nvim' }, })
  require('yazi').setup({
      floating_window_scaling_factor = 1.0,
      keymaps = {
        show_help = "~",
      },
  })

  local miniclue = require('mini.clue')
  miniclue.setup({
    window = { delay = 0 },
    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-x>' },

      -- `g` key
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'x', keys = "'" },

      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },

      -- Window commands
      { mode = 'n', keys = '<C-w>' },

      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },

      -- Bracketed
      { mode = 'n', keys = '[' },
      { mode = 'n', keys = ']' },

    },
    clues = {
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
  })
  
end)

