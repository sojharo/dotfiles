"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Sojharo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable                           " Turn on syntax highlighting.
filetype plugin on                      " Enable vim to recognize different file types
colorscheme medic_chalk                 " Color Scheme
set shortmess+=I                        " Disable the default Vim startup message.
set showcmd                             " Display an incomplete command
set hidden                              " Hide the unsaved buffers
set backspace=indent,eol,start          " Backspace behaves normally

" Finding Files "
" Provides tab-completion for all file-related tasks
set path+=server/**,client/**,src/**    " Search down into subfolders
set wildmenu                            " display completion matches in a status line

" Split Config "
set splitbelow                          " Open new vertical split bottom
set splitright                          " Open new horizontal splits right
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize +3<CR>
nnoremap <silent> <C-Down> :resize -3<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spaces, Tabs and Completion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2                           " number of visual spaces per TAB
set softtabstop=2                       " number of spaces in tab when editing
set expandtab                           " tabs are spaces, mainly because of python
set shiftwidth=2                        " tabs when inserted with >>
filetype indent on                      " Setup for file type indents
set autoindent                          " enable the autoindent
set dictionary+=/usr/share/dict/words   " completion from dictionary

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch                           " search as characters are entered
set hlsearch                            " highlight matches
set ignorecase                          " Ignore case in searches by default
set smartcase                           " But make it case sensitive if an uppercase is entered

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line Numbering
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                              " Show line numbers.
set relativenumber                      " Show relative line numbers

" Automatic toggling between line number modes "
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor Line Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline                          " Highlight current line

" Automatic toggling cursor highlight on different modes 
augroup cursorlinetoggle
  autocmd!
  autocmd InsertLeave * set cursorline
  autocmd InsertEnter * set nocursorline
augroup END
  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line  Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2                        " Always show the status line at the bottom,

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#DiffDelete#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%<
set statusline+=\ %{strftime('%b\ %d\ %H:%M\ %p\ ')} 
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ [%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c\ 
set statusline+=%#PmenuSel#
set statusline+=\ %L
set statusline+=\ 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Be careful to use your own path here instead of mine
nnoremap ,route :-1read $HOME/Learning/dotfiles/snippets/skeleton.route.js<CR>fi

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Not using it for now. May use in future when I need it for other files
" autocmd FileType javascript setlocal tabstop=2 softtabstop=2 expandtab shiftwidth=2 omnifunc=javascriptcomplete#CompleteJS 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = { 'javascript': ['standard'] }
let g:ale_fixers = {'javascript': ['standard']}
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
