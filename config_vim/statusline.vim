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
set statusline+=%#DiffChange#
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
