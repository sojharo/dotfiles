"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Sojharo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable                             " Turn on syntax highlighting.
filetype plugin on                        " Enable vim to recognize different file types
colorscheme monokai                       " Color Scheme
set shortmess+=I                          " Disable the default Vim startup message.
set showcmd                               " Display an incomplete command
set hidden                                " Hide the unsaved buffers
set backspace=indent,eol,start            " Backspace behaves normally

" Finding Files "
" Provides tab-completion for all file-related tasks
set path+=server/**,client/**,src/**      " Search down into subfolders
set path+=public/**
set wildmenu                              " display completion matches in a status line

" Split Config "
set splitbelow                            " Open new vertical split bottom
set splitright                            " Open new horizontal splits right
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize +3<CR>
nnoremap <silent> <C-Down> :resize -3<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spaces, Tabs and Completion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2                             " number of visual spaces per TAB
set softtabstop=2                         " number of spaces in tab when editing
set expandtab                             " tabs are spaces, mainly because of python
set shiftwidth=2                          " tabs when inserted with >>
filetype indent on                        " Setup for file type indents
set autoindent                            " enable the autoindent
set dictionary+=/usr/share/dict/words     " completion from dictionary

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch                             " search as characters are entered
set hlsearch                              " highlight matches
set ignorecase                            " Ignore case in searches by default
set smartcase                             " But make it case sensitive if an uppercase is entered

" Remove the highlighting when I insert ,<space>
nnoremap <silent> ,<space> :nohlsearch<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line Numbering
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                                " Show line numbers.
set relativenumber                        " Show relative line numbers

" Automatic toggling between line number modes "
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor Line and Column Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline                            " Highlight current line
set cursorcolumn                          " Highlight cursor column for code indents matching

" Automatic toggling cursor highlight on different modes 
augroup cursorlinetoggle
  autocmd!
  autocmd InsertLeave * set cursorline
  autocmd InsertEnter * set nocursorline
augroup END
  
" Automatic toggling cursor column highlight on different modes 
augroup cursorcolumntoggle
  autocmd!
  autocmd InsertLeave * set cursorcolumn
  autocmd InsertEnter * set nocursorcolumn
augroup END
  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line  Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/dotfiles/config_vim/statusline.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" snippets & mappings for making coding easy
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" be careful to use your own path here instead of mine
nnoremap ,route :-1read $HOME/dotfiles/snippets/skeleton.route.js<CR>fi
inoremap ,log console.log()<left>
nnoremap ,/ I// <ESC>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" External Vim Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Be careful to use your own path here instead of mine
source $HOME/dotfiles/config_vim/autoclose.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Not using it for now. May use in future when I need it for other files
" Further discussion on https://www.reddit.com/r/vim/comments/gqxmcd/just_published_my_vim_configuration_trying_to_go/
" autocmd FileType javascript setlocal tabstop=2 softtabstop=2 expandtab shiftwidth=2 omnifunc=javascriptcomplete#CompleteJS 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ale for code linting and fixing
let g:ale_linters = { 'javascript': ['standard'] }
let g:ale_fixers = {'javascript': ['standard']}
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" Coc for Intellisense
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other Resources
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For vim colorschemes:
"
" https://github.com/crusoexia/vim-monokai
" https://github.com/ParamagicDev/vim-medic_chalk
"
" vim colorschemes are stored in ~/.vim/colors on macos
