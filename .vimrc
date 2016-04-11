
" avoid exit 1
filetype on

""""""""""""""""""""""""""""" start use vundle """"""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""" end use vundle """"""""""""""""""""""""""""""""""""""""""""""""""

"let g:rustfmt_autosave = 1
Plugin 'rust-lang/rust.vim'


"disable some commands for .vimrc not in ~
set exrc
set secure

set nocp
set expandtab
set ts=2
set shiftwidth=2
set nu

"highlight column limit
set colorcolumn=100
highlight ColorColumn ctermbg=darkgray

let &path.="/usr/include,"

set smartindent

" show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" give me some syntax highlighting
syntax on

" set gvim window size
if has("gui_running")
  set lines=60 columns=110
endif

"vim-pathogen: manage runtimepath
execute pathogen#infect()

" Used by vim-airline
"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

""""""""""""""" Replace the tab shortcuts I'd no longer be using?"""""

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind this mapping
nmap <Tab>t :enew<CR>

" Move to the next buffer
nmap <Tab><Left>  :bprevious<CR>

" Move to the previous buffer
nmap <Tab><Right> :bnext<CR>

" Close the current buffer and move to the previous one
" This replaces the idea of closing a tab
nmap <Tab>q :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <Tab>l :ls<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F2> :echo 'Current time is ' . strftime('%c')<CR>
