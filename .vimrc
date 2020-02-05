let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "python3"
let g:vim_bootstrap_editor = "nvim"              " nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  "  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"""""""" PLUGINS GO HERE

""""" git stuff
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
Plug 'airblade/vim-gitgutter' " enable visual aids in relation to github in your files
if exists("*fugitive#statusline")
	  set statusline+=%{fugitive#statusline()}
endif

" this lets gitgutter update if termnial does not report focus, if you use tmux you can also do this: 
" 'set -g focus-events on' in your tmux config
let g:gitgutter_terminal_reports_focus=0
"" Open current line on GitHub
nnoremap <Leader>b :.Gbrowse<CR>

"" git commands, leader is comma, so ',ga' does GWrite
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>
"""" end git stuff

"""" ansible
Plug 'pearofducks/ansible-vim'
augroup ansible_vim_fthosts
	  autocmd!
	    autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
augroup END
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = "ob"
"vailable flags (> are default):
"
"   >a: highlight all instances of key=
"    o: highlight only instances of key= found on newlines
"   >d: dim the instances of key= found
"    b: brighten the instances of key= found
"    n: turn this highlight off completely

let g:ansible_name_highlight = 'd'
"	off by default
"    d: dim the instances of name: found
"    b: brighten the instances of name: found
"

call plug#end()

""""""" END OF PLUGINS




""""" VIM CONFIG

"" encoding

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" fix backspace indent thingy
set backspace=indent,eol,start

"""""""" keybinds that are not related to plugins
""" sets

set pastetoggle=<F10>

""" lets

let mapleader=','

""" maps

" this one starts a terminal, by my default hit : ,sh enter
nnoremap <silent> <leader>sh :terminal<CR>

" split vim

"" Split (,h = horizontal) (,v = vertical)
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Tabs (literal tab to swap in tabs),S-tab = shift TAB, S-t shift T
nnoremap <Tab> gt 
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory if you opened it in the wrong one, keybind (,.)
nnoremap <leader>. :lcd %:p:h<CR>

""""" fancy buffer work

"" Buffer nav, leader is , by default.
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight) comma space
nnoremap <silent> <leader><space> :noh<cr>


"" Switching windows if you use that feature
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv




"""" END KEYBINDS


"" my default tab settings, autocmd overwrites if needed
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

"" file
set fileformats=unix,dos,mac

"" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"" Shell settings

if exists('$SHELL')
	set shell=$SHELL
else
	set shell=/bin/bash
endif


"" Visual changes

syntax on
set ruler
set number

let no_buffers_menu=1
set guioptions=egmrti
set gfn=Monospace\ 10

" no blinky cursor
set gcr=a:blinkon0
set scrolloff=3

" the status bar
set laststatus=2

set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F


set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\


" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"*****************************************************************************
"" Abbreviations cuz we fatfinger a lot... a lot
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END



