" Configuration file for vim
"
" Davide Alberani's vimrc
"
" email: da AT erlug.linux.it
" home page: http://www.mimante.net/
" old vim's pages: http://www.mimante.net/vim/
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"

" Main settings
set nocompatible
set encoding=utf-8
set viminfo=!,'100,\"1000,c
set history=1000
set undolevels=1000
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set dictionary=/usr/share/dict/italian,/usr/share/dict/american-english
set directory=~/tmp,/tmp,.
set helpfile=$VIMRUNTIME/doc/help.txt
let myfiletypefile = "~/.vim/filetypes.vim"

" Activate pathogen
filetype off
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" Buffers
set hidden
set nobackup
set nomodeline
"set modelines=1
"set autowrite
"set exrc

" Tabs, indentation, wrapping, movements
set tabstop=8
set smarttab
set copyindent
set noautoindent
set backspace=indent,eol,start
set joinspaces
set textwidth=0
set nostartofline
set whichwrap=b,s,h,l

" Appearance, terminal integration
set ruler
set laststatus=2
set scrolloff=1
set showcmd
set ttyfast
set mouse=hvr
set title
set icon
set noshowmode
set switchbuf=usetab,newtab
set noerrorbells
"set cursorline

" Search
set incsearch
set ignorecase
set infercase
set smartcase
set nohlsearch
"set showmatch
"set matchtime=5

" Folding
set foldmethod=syntax
set foldlevel=99

" Line numbers
" set number
" set numberwidth=5

" Commands and aliases
com Decrypt %!gpg --decrypt
com Crypt %!gpg -a -se
com Sign %!gpg --clearsign
com -bang W w<bang>
com -bang Q q<bang>
com -bang Wq wq<bang>
com -bang WQ wq<bang>
com -bang Qa qa<bang>
com -bang QA qa<bang>

" Mappings
map Q gq
:nnoremap <silent> <F2> :YRShow<CR>
nnoremap <F4> :execute 'NERDTreeToggle ' . getcwd()<CR>
nnoremap <F6> :set fileformat=unix<CR>
nnoremap <F7> :set fileformat=dos<CR>
nnoremap <F8> :TagbarToggle<CR>
set pastetoggle=<F9>
nnoremap <F10> :GundoToggle<CR>
" Make p in Visual mode replace the selected text with the " register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>


" UltiSnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ultisnips_python_style="sphinx"

" Python-mode
let g:pymode_options = 0
let g:pymode_rope = 0
"let g:pymode_rope_guess_project = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_autoimport = 0
let g:pymode_lint_sort = ['E', 'C', 'I']
let g:pymode_options_max_line_length = 120

" jedi-vim
autocmd FileType python setlocal completeopt-=preview

" Tagbar
let g:tagbar_left=1

" Airline
" Be sure to have your TERM environment variable set to xterm-256color
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let airline#extensions#tabline#ignore_bufadd_pat = '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'

" yankring
let g:yankring_max_history = 1000
let g:yankring_min_element_length = 2
let g:yankring_history_dir = '$HOME/.vim,$HOME'

" Terminals and color schemes
if &term =~ "xterm-debian" || &term =~ "xterm-color" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm
endif

if &t_Co > 2 || has("gui_running")
  set background=dark
  syntax on
  "let g:solarized_termcolors=256
  colorscheme solarized
  "colorscheme koehler
endif

" Autocommands
if has("autocmd")
  filetype plugin on
  filetype indent on

  " Debian-specific
  augroup filetype
    au BufRead reportbug.*                set ft=mail
    au BufRead reportbug-*                set ft=mail
  augroup END

  " Auto-close scratch window (comment out the second, to leave
  " it open until you exit the insert-mode)
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
endif " has ("autocmd")

