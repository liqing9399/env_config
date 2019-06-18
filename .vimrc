"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Amir Salihefendic — @amix3k
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions


" ------------------- write by myself begin -------------------
set nu
set hls
nmap ,, *
nmap ;e $
nmap ;h ^
nmap ;; %
nmap m  N
nmap ge G
nmap <F3> :NERDTreeToggle<CR>

"不同时显示多个文件的tag，只显示当前文件的
let Tlist_Show_One_File=1

"如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Exit_OnlyWindow=1

"将taglist与ctags关联
let Tlist_Ctags_Cmd="/usr/bin/ctags"

"let Tlist_Ctags_Cmd="/usr/bin/ctags"
nmap T :Tlist<CR>

set nocompatible

" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

" if has(autocmd)
"   autocmd! bufwritepost vimrc source ~/.
" endif


" -------------------- end --------------------------------------


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
"command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

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

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

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

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

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

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

set tags=./tags,./TAGS,tags;~,TAGS;

"删除行尾空格
autocmd BufWritePre * %s/\s\+$//e




" 第一版
"let mapleader = ","
"nmap <leader>s : call SetTitle()<cr>
"配置文件初始化内容。

"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.sh,*.py,*.java exec ":call SetTitle()"
""""定义函数SetTitle，自动插入文件头
function! SetTitle()
      "如果文件类型为.sh文件
      if &filetype == 'sh'
          call setline(1,"\#!/bin/bash")
          call append(line("."),"\#########################################################################")
          call append(line(".")+1, "\# File Name   : ".expand("%"))
          call append(line(".")+2, "\# Author      : litao")
          call append(line(".")+3, "\# Email       : 362085095@qq.com")
          call append(line(".")+4, "\# Blog        ：http:// ")
          call append(line(".")+5, "\# Created Time: ".strftime("%c"))
          call append(line(".")+6, "\#########################################################################")
          call append(line(".")+7, "")
      elseif &filetype == 'python'
          call setline(1,"\#!/usr/bin/env python")
          call append(line("."),"\#########################################################################")
          call append(line(".")+1, "\# File Name    : ".expand("%"))
          call append(line(".")+2, "\# Author       : litao")
          call append(line(".")+3, "\# Email        : 362085095@qq.com")
          call append(line(".")+4, "\# Blog         ：http:// ")
          call append(line(".")+5, "\# Created Time : ".strftime("%c"))
          call append(line(".")+6, "\#########################################################################")
          call append(line(".")+7, "")
      "else
      "    call setline(1, "/*************************************************************************")
      "    call append(line("."),   "\# File Name    : ".expand("%"))
      "    call append(line(".")+1, "\# Author       : litao")
      "    call append(line(".")+2, "\# Email        : 362085095@qq.com")
      "    call append(line(".")+3, "\# Blog         ：http:// ")
      "    call append(line(".")+4, "\# Created Time : ".strftime("%c"))
      "    call append(line(".")+5, "************************************************************************/")
      "    call append(line(".")+6, "")
      endif
      "if &filetype == 'cpp'
      "    call append(line(".")+7, "#include <iostream>")
      "    call append(line(".")+8, "using namespace std;")
      "    call append(line(".")+9, "")
      "endif
      "if &filetype == 'hpp'
      "    call append(line(".")+7, "#include <iostream>")
      "    call append(line(".")+8, "using namespace std;")
      "    call append(line(".")+9, "")
      "endif
      "if &filetype == 'c'
      "    call append(line(".")+7, "#include<stdio.h>")
      "    call append(line(".")+8, "")
      "endif
"新建文件后，自动定位到文件末尾
endfunction
autocmd BufNewFile * normal G



"nmap <leader>a :call AddAuthor()<cr>
"nmap <leader>u :call UpdateTitle()<cr>
"
"function! AddAuthor()
"        let n=1
"        while n < 5
"            let line = getline(n)
"            if line =~'^\s*\*\s*\S*Last\s*modified\s*:\s*\S*.*$'
"            call UpdateTitle()
"            return
"            endif
"            let n = n + 1
"        endwhile
"        call AddTitle()
"endfunction
"
"function! UpdateTitle()
"        normal m'
"        execute '/* Last modified\s*:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
"        normal "
"        normal mk
"        execute '/* Filename\s*:/s@:.*$@\=": ".expand("%:t")@'
"        execute "noh"
"        normal 'k
"        echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
"endfunction
"
"function! AddTitle()
"        "call append(0,"#!/usr/local/python3/bin/python3")
"        call append(1,"############################################################")
"        call append(2,"# Author        : litao")
"        call append(3,"# Email         : 362085095@qq.com")
"        call append(4,"# Last modified : ".strftime("%Y-%m-%d %H:%M"))
"        call append(5,"# Filename      : ".expand("%:t"))
"        call append(6,"# Description   : ")
"        call append(7,"###########################################################")
"        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
"endfunction






" 第三版本
autocmd BufNewFile *.cpp,*.hpp,*.[ch] exec ":call FileHead()"
map <F7> :call FileHead()<CR>
let mapleader = ","
nmap <leader>a : call MainFun()<cr>

function! FileHead()
    call append( 0,"/***************************************************")
    call append( 1,"#filename      : ".expand("%:t")                     )
    call append( 2,"#author        : litao"                              )
    call append( 3,"#e-mail        : 362085095@qq.com"                   )
    call append( 4,"#create time   : ".strftime("%Y-%m-%d %H:%M:%S")     )
    call append( 5,"#last modified : ".strftime("%Y-%m-%d %H:%M:%S")     )
    call append( 6,"#description   : NA"                                 )
    call append( 7,"***************************************************/")
endfunction

function! MainFun()
    call append( 8,"#include <iostream>"                                 )
    call append( 9,"#include <vector>"                                   )
    call append(10,"#include <string>"                                   )
    call append(11,""                                                    )
    call append(12,"using namespace std;"                                )
    call append(13,"int main(int argc,char *argv[]) {"                   )
    call append(14,"  return 0;"                                         )
    call append(15,"}"                                                   )
    call append(16,""                                                    )
    call append(17,""                                                    )
    echo
endfunction

function! SetLastModifiedTimes()
    let line = getline(6)
    let newtime = "#last modified : ".strftime("%Y-%m-%d %H:%M:%S")
    let repl = substitute(line,".*$",newtime,"g")
    call setline(6,repl)
endfunction

autocmd BufWrite *.cpp,*.hpp,*.c,*.h call SetLastModifiedTimes()
