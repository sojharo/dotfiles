"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Sojharo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable                             " Turn on syntax highlighting.
filetype plugin on                        " Enable vim to recognize different file types
set termguicolors                         " Set 24-bit RGB colors
set background=dark
colorscheme codedark                      " Color Scheme
set shortmess+=I                          " Disable the default Vim startup message.
set showcmd                               " Display an incomplete command
set hidden                                " Hide the unsaved buffers
set backspace=indent,eol,start            " Backspace behaves normally

" Finding Files "
" Provides tab-completion for all file-related tasks
set path+=server/**,pages/**,src/**      " Search down into subfolders
set path+=public/**
set path+=service/**
set wildmenu                              " display completion matches in a status line

" Split Config "
set splitbelow                            " Open new vertical split bottom
set splitright                            " Open new horizontal splits right
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize +3<CR>
nnoremap <silent> <C-Down> :resize -3<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spaces, Tabs, folds and Completion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2                             " number of visual spaces per TAB
set softtabstop=2                         " number of spaces in tab when editing
set expandtab                             " tabs are spaces, mainly because of python
set shiftwidth=2                          " tabs when inserted with >>
filetype indent on                        " Setup for file type indents
set autoindent                            " enable the autoindent
set dictionary+=/usr/share/dict/words     " completion from dictionary

" In insert mode, enter should confirm the completion shown
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Folding
set foldmethod=syntax "syntax highlighting items specify folds  
set foldcolumn=1 "defines 1 col at window left, to indicate folding  
let javaScript_fold=1 "activate folding by JS syntax  
set foldlevelstart=99 "start file with all folds opened

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
nnoremap ;route :-1read $HOME/dotfiles/config_vim/snippets/skeleton.route.js<CR>fi
inoremap ,log console.log()<left>
nnoremap ;/ I// <ESC>

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

" Coc for Intellisense
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use ,k to close the floating window opened to show documentation using K
nnoremap <silent> ,k :call coc#float#close_all()<CR>

" Symbol renaming. (sometimes :%s/target/new/g works for me :) )
nmap <leader>rn <Plug>(coc-rename)

" Configuration for git messenger
let g:git_messenger_no_default_mappings = v:true
nmap <leader>b <Plug>(git-messenger)

let g:git_messenger_floating_win_opts = { 'border': 'single' }
let g:git_messenger_always_into_popup = v:true

" FZF settings
set rtp+=/opt/homebrew/opt/fzf
nmap <leader>f :call fzf#run({'sink': 'e', 'options': '--height 40% --reverse --border'})<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other Resources
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For vim colorschemes:
"
" https://github.com/crusoexia/vim-monokai
" https://github.com/ParamagicDev/vim-medic_chalk
" https://github.com/NLKNguyen/papercolor-theme
" https://github.com/tomasiser/vim-code-dark *
"
" vim colorschemes are stored in ~/.vim/colors on macos
