" Config tabs
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set tabstop=4
" Config backups
set backup
set backupdir=~/.vim/backup
if filewritable("~/.vim") && ! filewritable("~/.vim/backup")
  silent execute '!umask 002; mkdir ~/.vim/backup'
endif
" Config search
set ignorecase
set hlsearch
set smartcase

" Config encoding
set encoding=utf-8
set fileencoding=utf-8

" Make sure that coursor is always vertically centered on j/k moves
set so=999

syntax enable
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Highlight current line - allows you to track cursor position more easily
set cursorline
" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir
if filewritable("~/.vim") && ! filewritable("~/.vim/undodir")
   silent execute '!umask 002; mkdir ~/.vim/undodir'
endif

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif


set backspace=indent,eol,start

" Show line, column number, and relative position within a file in the status line
set ruler
" Show line numbers - could be toggled on/off on-fly by pressing F6
set number

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" A buffer becomes hidden when it is abandoned
set hid

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic


" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Make sure that extra margin on left is removed
set foldcolumn=0

try
    colorscheme desert
catch
endtry

set background=dark
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" highlight trailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


"перенос строки  по словам
set wrap linebreak nolist

set linebreak
set autoread
set nocompatible
colo desert
" set title

set noerrorbells
set history=1000
set noswapfile

set pastetoggle=<F3>

"Прикольные штуки autocomand
" restore-cursor last-position-jump
autocmd BufReadPost *
     \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
     \ |   exe "normal! g`\""
     \ | endif
"Use this in a modified buffer to see the differences with the file it was loaded from
 command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis

"------------
filetype plugin indent on

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle') "Начать искать плагины в этой директории
"Тут будут описаны наши плагины
Plug 'https://github.com/scrooloose/nerdtree.git' |
  \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://tpope.io/vim/fugitive.git'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end() "Перестать это делать

" nerdtree
"autocmd vimenter * NERDTree " Открывать дерево каталогов при запуске VIM
" Автоматически закрыть окно, если больше ничего нет
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" -------------
"  airline
let g:airline_powerline_fonts = 0
let g:airline_theme='deus'
"  ----------------
" Ctrl + G скрыть окно
map <C-g>  :NERDTreeToggle<CR>
" This is totally awesome - remap jj to escape in insert mode.
inoremap jj <esc>
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer (w/o closing the current window)
map <leader>bd :Bclose<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tj :tabnext
map <leader>tk :tabprevious

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm



