" ~~~ Leader Shortcuts ~~~
let mapleader=","         " set leader to comma


" ~~~ Colors ~~~
syntax on                   " enable syntax highlighting
set t_Co=256                " tell vim it's OK to use 256 colors at terminal


" ~~~ Spaces & Tabs ~~~
set tabstop=2               " number of visual spaces per [Tab]
set softtabstop=2           " number of spaces in tab when editing
set shiftwidth=2            " number of spaces when using << or >>
set expandtab               " tabs are spaces
set backspace=indent,eol,start " make backspace delete sensibly
set autoindent              " use indentation from previous line


" ~~~ Plugs ~~~
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()


" ~~~ UI Config ~~~
set number                  " show line numbers
"set cursorline             " highlight current line
set wildmenu                " visual autocomplete for command e:
set lazyredraw              " redraw only when needed
set showmatch               " highlight matching [{()}]
set colorcolumn=80          " display vertical line at n chars
set hidden                  " suppress warning when switching off unsaved buffer
set nowrap                  " do not wrap long lines

" configure display of invisible characters; map to <leader>l
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set list                    " display invisible by default
nmap <leader>l :set list!<CR>


" ~~~ Searching ~~~
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set ignorecase              " ignore case when searching in lowercase...
set smartcase               " ...unless uppercase in search pattern

" turn off search highlight when done
nnoremap <leader>c :nohlsearch<CR>


" ~~~ Folding ~~~
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=10          " 10 nested folds max

" space open/closes folds
nnoremap <space> za
set foldmethod=indent       " fold based on indent level


" ~~~ Movement ~~~
" simply switch window commands
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" set <esc> to jk
inoremap jk <esc>

" save session; restore with vim -S
nnoremap <leader>s :mksession<CR>

" insert extra line with <CR>
map <CR> O<Esc>k

" sudo write file
cmap w!! %!sudo tee > /dev/null %

" ~~~ Backups ~~~
set backupdir=~/.vim/tmp/                   " for the backup files
set directory=~/.vim/tmp/                   " for the swap files

" show 3 lines above or below cursor when scrolling
set scrolloff=3

" turn on relative line number
" set relativenumber

" assumes fast connection
set ttyfast

" show line and column number
set ruler

" turn off mouse pointer when typing begins
set mousehide

" put mouse in command-line mode, so mouse clicks don't move cursor
set mouse=c

" only do this part when compiled with support for autocommands
if has("autocmd")
  autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()
endif

" strip trailing whitespace on F5 & on save
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
  " preparation: save last search, and curson position.
  let _s=@/
  let l=line(".")
  let c=col(".")
  " do the business
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
