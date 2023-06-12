set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set number
set title
set wildmenu

command Conf tabnew ~/AppData/Local/nvim/init.vim

let g:gruvbox_contrast_dark='hard'
let g:airline_theme='powerlineish'

call plug#begin("~/.vim/plugged")
" NVIM PLUGINS
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'rust-lang/rust.vim'
call plug#end()
" NVIM CONFIG
"if (has("termguicolors"))
"	set termguicolors
"endif

lua << END
require('plugins')
END

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

syntax enable
colorscheme gruvbox

let g:bargreybars_auto=0
let g:airline_solorized_bg='dark'
let g:airline_powerline_fonts=1
let g:airline#extension#tabline#enable=1
let g:airline#extension#tabline#left_sep=' '
let g:airline#extension#tabline#left_alt_sep='|'
let g:airline#extension#tabline#formatter='unique_tail'
let NERDTreeQuitOnOpen=1

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " Toggle
"nnoremap <silent> <C-b> :NERDTreeToggle<CR>
nnoremap <silent> <C-b> :NvimTreeToggle<CR>

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
	split term://bash
	resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" SPACES AND TABS
set tabstop=4       " Number of visual spaces per tab
set softtabstop=4   " Number of spaces for tab in edit mode
set shiftwidth=4    " Number of spaces in an autoindent
set expandtab       " Converts TAB to spaces
set autoindent		
set copyindent		" Copies indent from the previous line
