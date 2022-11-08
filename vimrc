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
"

" ------------------- write by myself begin -------------------
call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'flazz/vim-colorschemes'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
call plug#end()

let mapleader = ","
" 设为 1 ale 失效， 0 则有效。
let g:ale_linters_explicit = 0
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
"let g:ale_lint_on_text_changed = 'normal'
"let g:ale_lint_on_insert_leave = 1
set fenc=

" ale-setting {{{
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"let g:ale_statusline_format = ['{%d}', '{%d}', '']
let g:airline#extensions#ale#enabled = 1
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" 0 打开文件时不进行检查 ， 1 则检查
let g:ale_lint_on_enter = 1
" 1
let g:ale_open_list = 0

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
"使用gcc和g++对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
      \   'c++': ['g++'],
      \   'c': ['g++'],
      \   'python': ['pylint'],
      \}
let g:ale_cpp_gcc_options = '-Wall -Wno-sign-compare -O3 -std=c++14 '
let g:ale_c_parse_compile_commands = 1

let g:ale_c_gcc_options = '-Wall -Wno-sign-compare -O3 -std=c++14'
let g:ale_c_cppcheck_options = ''

let g:ale_cpp_cppcheck_executable = 'cppcheck'
"let g:ale_cpp_cppcheck_options = '--enable=all'
let g:ale_cpp_cppcheck_options = '--enable=style'
let g:ale_cpp_cpplint_executable ='cpplint'
let g:ale_cpp_cpplint_options = ''
" 查看当前行所有的错误与警告
" :lopen

function! LinterStatus() abort
      let l:counts = ale#statusline#Count(bufnr(''))
      let l:all_errors = l:counts.error + l:counts.style_error
      let l:all_non_errors = l:counts.total - l:all_errors
      return l:counts.total == 0 ? 'OK' : printf(
             \   '⚡%dW ✗%dE',
             \   all_non_errors,
             \   all_errors
             \)
endfunction
" Format the status line
set statusline=\%{LinterStatus()}\ \ %{HasPaste()}%F%m%r%h\ %w\ \ Line:\ %l\ \ Column:\ %c
"set statusline=\%{LinterStatus()}\ \ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


set nu
set hls
set cc=89
"换行不自动注释
set paste
"删除空白行
nnoremap <leader>r :g/^\s*$/d<cr>

" nnoremap 表示不递归映射，建议全部替换为nnoremap
nnoremap ,, *
nnoremap ;e $
nnoremap ;h ^
nnoremap ;; %
nnoremap m  N
nnoremap ge G

"将当前单词使用“”扩起来。
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <F3> :NERDTreeToggle<CR>
inoremap jk <esc>
nnoremap <leader>i :ALEInfo<cr>

" 将esc映射为啥也不干，方便熟悉jk退出插入模式
"inoremap <esc> <nop>

" 如果是cpp则 使用映射之后的键会将当前行注释
autocmd FileType cpp     nnoremap <buffer> <leader>c I//<esc>

" 插入模式下， 单独的 @@ 字符将会呗替换成 litao@cambricon.com
iabbrev @@ litao@cambricon.com

"note: 头文件中为实现的函数不显示。

"不同时显示多个文件的tag，只显示当前文件的
let Tlist_Show_One_File=1

"如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Exit_OnlyWindow=1

"将taglist与ctags关联
"let Tlist_Ctags_Cmd="~/stochasticNeuralNetwork/ctags"
let Tlist_Ctags_Cmd="/usr/bin/ctags"

nnoremap T :Tlist<CR>

set nocompatible

" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

" if has(autocmd)
"   autocmd! bufwritepost vimrc source ~/.
" endif

" 插入模式下上下左右移动光标  linux 命令行可用，cmder不可用。
 inoremap <c-h> <left>
 inoremap <c-l> <right>
 inoremap <c-j> <c-o>gj
 inoremap <c-k> <c-o>gk


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
    "colorscheme molokai 
    colorscheme gruvbox
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
nnoremap <c-space> :set noic<cr>?
nnoremap <space> :set noic<cr>/

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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
    autocmd BufWritePre *.cpp,*.hpp,*.c,*.h,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
    "autocmd BufWritePre * %s/\s\+$//e
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




"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.sh,.java文件，自动插入文件头
autocmd BufNewFile *.sh,*.py,*.java exec ":call Scritpt_FileHead()"
function! Scritpt_FileHead()
    if &filetype == 'sh'
        call append( 0,"#######s############################################")
        call append( 1,"#filename      : ".expand("%:t")                     )
        call append( 2,"#author        : litao"                              )
        call append( 3,"#e-mail        : 362085095@qq.com"                   )
        call append( 4,"#create time   : ".strftime("%Y-%m-%d %H:%M:%S")     )
        call append( 5,"#last modified : ".strftime("%Y-%m-%d %H:%M:%S")     )
        call append( 6,"####################################################")
        call append( 7,"\#!/bin/bash")
    elseif &filetype == 'python'
        call append( 0,"#######p############################################")
        call append( 1,"#filename      : ".expand("%:t")                     )
        call append( 2,"#author        : litao"                              )
        call append( 3,"#e-mail        : 362085095@qq.com"                   )
        call append( 4,"#create time   : ".strftime("%Y-%m-%d %H:%M:%S")     )
        call append( 5,"#last modified : ".strftime("%Y-%m-%d %H:%M:%S")     )
        call append( 6,"####################################################")
        call append( 7,"\#!/usr/bin/env python")
    endif
endfunction
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G
map <F6> :call Scritpt_FileHead()<CR>

function! Script_SetLastModifiedTimes()
    let line = getline(6)
    let newtime = "#last modified : ".strftime("%Y-%m-%d %H:%M:%S")
    if -1 == match(line, "last modified") "not match
      call Scritpt_FileHead();
    else  "match
      let repl = substitute(line,".*$",newtime,"g")
      call setline(6,repl)
    endif
endfunction

"autocmd BufWrite *.sh,*.py call Script_SetLastModifiedTimes()

"新建.cpp, .hpp, .c, .h文件，自动插入文件头
autocmd BufNewFile *.cpp,*.hpp,*.[ch] exec ":call C_FileHead()"
function! C_FileHead()
    call append( 0,"/***************************************************")
    call append( 1,"#filename      : ".expand("%:t")                     )
    call append( 2,"#author        : litao"                              )
    call append( 3,"#e-mail        : 362085095@qq.com"                   )
    call append( 4,"#create time   : ".strftime("%Y-%m-%d %H:%M:%S")     )
    call append( 5,"#last modified : ".strftime("%Y-%m-%d %H:%M:%S")     )
    call append( 6,"#description   : NA"                                 )
    call append( 7,"***************************************************/")
endfunction
map <F7> :call C_FileHead()<CR>

function! C_MainFun()
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
nmap <leader>m : call C_MainFun()<cr>

function! C_SetLastModifiedTimes()
    let line = getline(6)
    let newtime = "#last modified : ".strftime("%Y-%m-%d %H:%M:%S")
    if -1 == match(line, "last modified") "not match
      call C_FileHead()<cr>;
    else  "match
      let repl = substitute(line,".*$",newtime,"g")
      call setline(6,repl)
    endif
endfunction

"autocmd BufWrite *.cpp,*.hpp,*.c,*.h call C_SetLastModifiedTimes()
nmap <leader>u : call C_SetLastModifiedTimes()<cr>

set cursorline                          "高亮当前行
set cursorcolumn                        "高亮当前列
highlight CursorLine   cterm=NONE ctermbg=green ctermfg=NONE guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=green ctermfg=NONE guibg=NONE guifg=NONE

