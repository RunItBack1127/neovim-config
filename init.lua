local global = vim.o
local window = vim.wo
local buffer = vim.bo

global.clipboard = "unnamedplus"
global.completeopt = "noinsert,menuone,noselect"
global.cursorline = true
global.inccommand = "split"
global.hidden = true
global.title = true
global.wildmenu = true
global.background = "dark"
global.termguicolors = true

vim.cmd [[let $NVIM_TUI_ENABLE_TRUE_COLOR=1]]

-- Tabby configuration
global.showtabline = 2

window.number = true

buffer.tabstop = 4
buffer.softtabstop = 4
buffer.shiftwidth = 4
buffer.expandtab = true
buffer.autoindent = true
buffer.copyindent = true

vim.cmd [[syntax enable]]
vim.cmd [[colorscheme gruvbox]]

require('plugins')
require('statusline')
require('tree')

local theme = {
  fill = 'TabLineFill',
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  head = 'TabLine',
  -- current_tab = 'TabLineSel',
  current_tab = { fg = '#dddddd', bg = '#222222' },
  win = { fg = '#dddddd', bg = '#222222' },
  tab = 'TabLine',
  win = 'TabLine',
  tail = 'TabLine',
}

require('tabby.tabline').set(function(line)
  window_set = {}
  return {
    {
      { '    ', hl = theme.head },
      line.sep('', theme.head, theme.fill),
    },
    --[[
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        tab.is_current() and '    ' or '    ',
        tab.number(),
        ' ',
        hl = hl,
        margin = ' ',
      }
    end),
    line.spacer(),
    ]]--
    line.wins().foreach(function(win)
        local name = win.buf_name()
        if not string.find(name, "No Name") and not window_set[name] and not string.find(name, "NvimTree") then
           window_set[name] = true
           return {
             --win.is_current() and '    ' or '    ',
             ' ',
	         win.file_icon(),
	         ' ',
             name,
             '  ',
             hl = theme.win,
             margin = ' ',
           }
        end
     end),
    {
      line.sep('', theme.tail, theme.fill),
      { '   ', hl = theme.tail },
    },
    hl = theme.fill,
  }
end)

local function custom_bindings()
	local api = require('nvim-tree.api')

	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set('n', '<CR>', api.node.open.tab, opts('Open: New Tab'))
end

require("nvim-tree").setup({
	on_attach = custom_bindings
})

local api = vim.api
api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
api.nvim_create_user_command('Conf', 'tabnew ~/AppData/Local/nvim/init.lua', {})
