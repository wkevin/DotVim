"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: amix the lucky stiff
"             http://amix.dk - amix@amix.dk
"
" Version: 3.3 - 21/01/10 01:05:46
"
" Blog_post: 
"       http://amix.dk/blog/post/19486#The-ultimate-vim-configuration-vimrc
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
" How_to_Install:
"    $ mkdir ~/.vim_runtime
"    $ svn co svn://orangoo.com/vim ~/.vim_runtime
"    $ cat ~/.vim_runtime/install.sh
"    $ sh ~/.vim_runtime/install.sh <system>
"      <sytem> can be `mac`, `linux` or `windows`
"
" How_to_Upgrade:
"    $ svn update ~/.vim_runtime
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Command mode related
"    -> Moving around, tabs and buffers
"    -> Statusline
"    -> Parenthesis/bracket expanding
"    -> General Abbrevs
"    -> Editing mappings
"
"    -> Cope
"    -> Minibuffer plugin
"    -> Omni complete functions
"    -> Python section
"    -> JavaScript section
"
" Plugins_Included:
"     > minibufexpl.vim - http://www.vim.org/scripts/script.php?script_id=159
"       Makes it easy to get an overview of buffers:
"           info -> :e ~/.vim_runtime/plugin/minibufexpl.vim
"
"     > bufexplorer - http://www.vim.org/scripts/script.php?script_id=42
"       Makes it easy to switch between buffers:
"           info -> :help bufExplorer
"
"     > yankring.vim - http://www.vim.org/scripts/script.php?script_id=1234
"       Emacs's killring, useful when using the clipboard:
"           info -> :help yankring
"
"     > surround.vim - http://www.vim.org/scripts/script.php?script_id=1697
"       Makes it easy to work with surrounding text:
"           info -> :help surround
"
"     > snipMate.vim - http://www.vim.org/scripts/script.php?script_id=2540
"       Snippets for many languages (similar to TextMate's):
"           info -> :help snipMate
"
"     > fuzzyfinder - http://www.vim.org/scripts/script.php?script_id=1984
"       Find files fast (similar to TextMate's feature):
"           info -> :help fuzzyfinder@en
"
"  Revisions:
"     > 3.3: Added syntax highlighting for Mako mako.vim 
"     > 3.2: Turned on python_highlight_all for better syntax
"            highlighting for Python
"     > 3.1: Added revisions ;) and bufexplorer.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=300

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vim_runtime/vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim_runtime/vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
  set gfn=Monospace\ 10
  set shell=/bin/bash

if has("gui_running")
  set guioptions-=T
  set background=dark
  set t_Co=256
  set background=dark
  colorscheme peaksea

  set nu
else
  colorscheme zellner
  set background=dark
  
  set nonu
endif

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

map <leader>t2 :setlocal shiftwidth=2<cr>
map <leader>t4 :setlocal shiftwidth=4<cr>
map <leader>t8 :setlocal shiftwidth=4<cr>


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Useful on some European keyboards
map ½ $
imap ½ $
vmap ½ $
cmap ½ $


func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> <C-d>
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <C-right> :bn<cr>
map <C-left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


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

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
"map <leader>cc :botright cope<cr>
"map <leader>n :cn<cr>
map <leader>p :cp<cr>


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1

let g:bufExplorerSortBy = "name"

autocmd BufRead,BufNew :call UMiniBufExplorer

map <leader>u :TMiniBufExplorer<cr>:TMiniBufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
au FileType python set nocindent
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => Fuzzy finder
""""""""""""""""""""""""""""""
try
    call fuf#defineLaunchCommand('FufCWD', 'file', 'fnamemodify(getcwd(), ''%:p:h'')')
    map <leader>t :FufCWD **/<CR>
catch
endtry


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
" noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kevin Modify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"====== var for vi/vim =====
set nu
set nowrap
" 编码
set fileencodings=utf8,gbk "打开、编辑、保存“已有文件”时的可用编码集，创建文件使用encoding
set termencoding= "默认空值，输出到终端不进行编码转换。
" 字体
set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI "记住空格用下划线代替哦
set gfw=幼圆:h10:cGB2312

"====== var for grep.vim =====

"====== var for TagList =====
let Tlist_Show_One_File=1
let Tlist_UseRight_Window=1
"let Tlist_WinWidth=20

"====== var for markdown =====
let g:vim_markdown_folding_disabled=1

"====== var for NERDTree =====
let NERDTreeWinPos='right'
let NERDTreeWinSize='35'
let NERDTreeQuitOnOpen='1'

"====== var for SrcExpl =====

" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 10 

" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 

" // Set "Enter" key to jump into the exact definition context 
"let g:SrcExpl_jumpKey = "<Enter>" 

" // Set "Space" key for back from the definition context 
"let g:SrcExpl_gobackKey = "<SPACE>" 

" // In order to avoid conflicts, the Source Explorer should know what plugins
" // except itself are using buffers. And you need add their buffer names into
" // below listaccording to the command ":buffers!"
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_" 
    \ ] 

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" // create/update the tags file 
let g:SrcExpl_updateTagsCmd = "ctags --langmap=java:+.aidl --exclude='.repo' --exclude='.git' --exclude='*.html' --sort=foldcase -R ." 

" // Set "<F12>" key for updating the tags file artificially 
"let g:SrcExpl_updateTagsKey = "<leader><F10>" 

" // Set "<F3>" key for displaying the previous definition in the jump list 
"let g:SrcExpl_prevDefKey = "<F7>" 

" // Set "<F4>" key for displaying the next definition in the jump list 
"let g:SrcExpl_nextDefKey = "<F8>" 

"====== var for ctrlp =====
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:500,results:500'
let g:ctrlp_regexp = 0
let g:ctrlp_max_files = 100000
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 1
" :CtrlpClearCache can clear the cache


"====== var for Tagbar =====
let g:tagbar_left = 1
let g:tagbar_sort = 0
"let g:tagbar_autopreview = 1
let g:tagbar_width = 30


"====== var for VOom =====
au BufNewFile,BufRead *.md :set filetype=markdown
let g:voom_ft_modes = {'markdown': 'markdown', 'tex': 'latex'}

"====== var for Others =====
set splitright

"==========================================
" Hot key configurationi
"==========================================

"===== save & close file =====
nmap <F2> :update<cr>
imap <F2> <Esc><Esc>:update<cr>
map <F4> :Bclose<cr>

"===== Find file =====
map f :CtrlP<CR>
map F :CtrlP
map <A-f> :CtrlPClearCache<CR>

"=== FufFile ===
map <leader>f :FufFile<CR>
map <leader>b :FufBuffer<CR>
map <leader>d :FufDir<CR>
"map <leader>c :FufMruCmd<CR>
map <leader>j :FufJumpList<CR>

"=== BufExplorer ===
"vim有个自有命令 :ls 或 :buffers ，能够列出所有buffer
"并且每个buffer有一个状态（状态符号的定义在 :help buffers 中可以查到
"a:activity  h:hide  ' ':noactivity
"%:buffer正在当前窗口中   #:buffer为前一个窗口（可以用 Ctrl-^）切换过去
"
"<leader>be == :BufExplorer                 //在当前窗口撑满显示buffer列表
"<leader>bt == :ToggleBufExplorer           //在当前窗口撑满显示或关闭buffer列表
"<leader>bs == :BufExplorerHorizontalSplit  //在上方split一个新窗口显示buffer列表
"<leader>bv == :BufExplorerVerticalSplit    //在右边split一个新窗口显示buffer列表
map <leader><leader> :BufExplorer<CR>
"在buffer列表中的操作有：
"<enter>：当前窗口打开      —— 时而当前窗口、时而新建窗口（令人苦恼）
"<shift-enter>：新建tab打开 —— 时而当前窗口、时而新建窗口，没见到新建tab
"o：当前窗口打开            —— 时而当前窗口、时而新建窗口
"上面的3种打开方式存在一个问题：
"    a/h状态(即：已经加载到内存）的buffer，打开会在原window
"    ' '状态（即：未加载到内存）的buffer，打开会在原window(:BufExplorer）或新建window(:BufExplorerxxxSplit)
"t：新建一个tab page来显示
"q：quit
"d：delete
"r：排序
"R：显示绝对路径

"===== Find string =====
"== Use vimgrep == can not dont ignore case
noremap <F3> :vimgrep /<C-R>=expand("<cword>")<CR>/j %:p<CR> \| :botright copen 20<cr>

"== Use /bin/grep == faster, but always jump to the first result
"map <F3> :grep <cword> %:p <cr> :copen 20<cr>
"map <F3><F3> :grep -wR --include=*.h --include=*.c  --include=*mak* --include=*.java --exclude-dir=.git --exclude=.svn

"== Use Grep vim plugin ==
let Grep_Default_Filelist = '*.h *.c *.cpp *.asm *.txt *.md'
let Grep_Skip_Dirs = '*.bak *~ *.git *.svn .deps'
let Grep_Skip_Files = 'tags *.html'
map <F3> :Bgrep -i<cr>
map <F3><F3> :Rgrep -i<cr>

"== quickfix shortcuts ==
map <leader>1  :botright copen 20<cr>
map <leader>2  :cprev<cr>
map <leader>3  :cnext<cr>
map <leader>4  :cclose<cr>

"===== Find symbal =====
" in Tagbar
map <F5> :TagbarToggle<cr>
map <F5><F5> :Tlist<cr>
let g:script_runner_key = '<leader><F5>'
" in current window
map <F6> :tj <C-R>=expand("<cword>")<cr><cr>
map <F7> :tp<cr>
map <F8> :tn<cr>
" in preview window
map s :vertical ptj <C-R>=expand("<cword>")<cr><cr>
"au! CursorHold *.[ch] nested :exe "silent! ptag " . expand("<cword>")  //preview window will in bufflist,so auto will be very much buffers
" in srcExpl window
nmap <F6><F6> :SrcExplToggle<cr>
let g:SrcExpl_updateTagsKey = "<leader><F6>"
let g:SrcExpl_prevDefKey = "<F7>"
let g:SrcExpl_nextDefKey = "<F8>"


"===== For markdown =====
" There are two plugins named "Vim-markdown" in github:
" http://github.com/plasticboy/vim-markdown.git -- bad,do not use
" http://github.com/gabrielelana/vim-markdown.git
map <F9> :Mer<cr>
map <F9><F9> :Me<cr>
map <leader><F9> :VoomToggle<cr>
" :Toc is a command in the plasticboy's Vim-markdown plugin 
"map <leader><F12> :Toc<cr>

"===== For reserve =====
"map <F10> // reserve for menu
"map <F11> // reserve for max size windows

"===== For NERDTree =====
map <F12> :NERDTreeFind<cr>
map <F12><F12> :NERDTreeToggle<cr>
map <leader><F12> :!dot "%" -Txlib<cr>

set pastetoggle=<leader><F12> 
"set paste //this option can make <F2>... useless

"===== Load external vimrc in current dir =====
if filereadable("vimrc")
    "echo "find vimrc"
    source vimrc
endif

"close the quickfix window when close a window, and jump out from tagbar window
aug QickfixAutoClose
  au!
  "au WinLeave * :if getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
  au WinLeave * :if getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"
  au WinLeave * :q
  au WinLeave * :if bufname("%") == "__Tagbar__"
  au WinLeave * :wincmd w
  au WinLeave * :endif
  au WinLeave * :endif
aug END

" markdown文件的高亮
let g:VMEPstylesheet = 'beautiful.css' 
let g:VMEPoutputdirectory = './'
au BufWinEnter *.md let b:VMEPoutputdirectory = expand('%:p:h')
let g:markdown_enable_spell_checking = 0

" 左侧边栏：符号表等
"au BufWinEnter *.md :VoomToggle
"au BufWinLeave *.md :Voomquit

"au BufWinEnter * :if getbufvar(winbufnr(winnr()),"current_syntax") =~ '\(c\|cpp\|java\|make\)' |NERDTreeFind|endif
"au BufWinEnter * nested :if getbufvar(winbufnr(winnr()),"current_syntax") =~ '\(c\|cpp\|java\|make\)' |TagbarOpen|endif
"aug toggleTagbar
"  au BufWinEnter * :if getftype(bufname("%")) == "file"
"  au BufWinEnter * :if getbufvar(winbufnr(winnr()),"current_syntax") =~ '\(c$\|cpp$\|java$\|make$\|vim$\|python\)' 
"  au BufWinEnter * :TagbarOpen
"  au BufWinEnter * :else
"  au BufWinEnter * :TagbarClose
"  au BufWinEnter * :endif
"  au BufWinEnter * :endif
"aug END 

" 保存会话
aug savesession
au VimLeave * :if bufname("%") != '.git/COMMIT_EDITMSG'
au VimLeave * :mks! .vim.session
au VimLeave * :endif
aug END

"当直接用vi不加文件名打开时，加载已有的session
if expand("%")==""
    if(expand("./.vim.session")==findfile("./.vim.session"))
         silent :source .vim.session
    endif
endif

set statusline=[%F]%=[Line:%l/%L:%c][%p%%] 


"=========== vundle begin ===============
" install vundle: 
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" 1) plugin from http://vim-scripts.org/vim/scripts.html -- very older than then in github
Plugin 'L9'
Plugin 'CRefVim'
Plugin 'FuzzyFinder'
Plugin 'genutils' " for vi script develpoer
Plugin 'lookupfile' " :LookupFile :LUPath :LUBufs :LUWalk :LUArgs
Plugin 'snipMate'
Plugin 'grep.vim' " :Grep|:Rgrep :Bgrep :[F|Rf]grep :[E|Re]grep :[A|Ra]grep

" 2) plugin from GitHub
Plugin 'tpope/vim-fugitive' " better than 'WolfgangMehner/git-support'
Plugin 'junegunn/gv.vim'
Plugin 'scrooloose/nerdtree' " newer than 'vim-scripts/The-NERD-tree'
Plugin 'craigemery/vim-autotag' " newer than 'vim-scripts/AutoTag' 1.search ctags file up and down 2.del entries and ctags -a
                                " better than 'vim-scripts/ctags.vim' " :GenerateTags :GetTagName 
Plugin 'vim-scripts/a.vim' " :A :AS :AV :AT :AN :IH :IHS :IHV :IHT :IHN ,ih ,is ,ihn
Plugin 'WolfgangMehner/c-support' " change from 'vim-scripts/c.vim'
Plugin 'jlanzarotta/bufexplorer' "\be \bt \bs \bv
Plugin 'scwbin/csExplorer' " :ColorSchemaExplorer -- list and change color schema
Plugin 'kien/ctrlp.vim'
Plugin 'wesleyche/SrcExpl' " :)
Plugin 'majutsushi/tagbar' " :TagbarToggle
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-voom/VOoM' " :VOom [markdown|python|...]
Plugin 'inkarkat/vim-MultiWordComplete' " CTRL-X w  
Plugin 'vim-scripts/YankRing.vim' " :h yankring.txt  :h yankring-tutorial
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"      Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"      avoid a Naming conflict 
" Plugin 'ascenator/L9', {'name': 'newL9'}

" 3) plugin from other git repo
"Plugin 'git://git.wincent.com/command-t.git'

" 4) plugin from a repo on my local machine
"Plugin 'file:///home/gmarik/path/to/plugin'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"=========== vundle end ===============
