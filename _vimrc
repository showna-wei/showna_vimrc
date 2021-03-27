" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
"######################################################################################################
"操控配置
"######################################################################################################
"self map setting
let mapleader = " "
inoremap jj <Esc>
nmap <CR> o<Esc>
vmap <leader><leader>y "+y
map <leader><leader>p "+gP
"用<c-r>加上寄存器名字来在命令行黏贴寄存器内容
cmap <leader><leader>p <C-r>+
inoremap <C-o> <Esc>o  
inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-b> <PageUp>
inoremap <C-f> <PageDown>
"set tab space
set ts=4
"使用>><<，以及=号自动缩进时的缩进空格
set shiftwidth=4
set expandtab
set nu
"hightlight search result
set hlsearch
"ignore case in search
set ic
"如果搜索时出现大写，就不忽略大小写
set smartcase
"启用256色"
set t_Co=256
set autoread
"设置备份文件、交换文件、操作历史文件的保存位置。
set backupdir=$VIM/.vimtemp/.backup//  
set directory=$VIM/.vimtemp/.swp//
set undodir=$VIM/.vimtemp/.undo//
"setting scheme
syntax enable
set background=light
colorscheme solarized
"######################################################################################################
"修改后自动重载vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
"######################################################################################################
"auto select input keyboard
"~let g:input_toggle = 0
"~function! Fcitx2en()
"~   let s:input_status = system("fcitx-remote")
"~   if s:input_status == 2
"~      let g:input_toggle = 1
"~      let l:a = system("fcitx-remote -c")
"~   endif
"~endfunction
"~	
"~function! Fcitx2zh()
"~   let s:input_status = system("fcitx-remote")
"~   if s:input_status != 2 && g:input_toggle == 1
"~      let l:a = system("fcitx-remote -o")
"~      let g:input_toggle = 0
"~   endif
"~endfunction
"~
"~set timeoutlen=150
"~autocmd InsertLeave * call Fcitx2en()
"~autocmd InsertEnter * call Fcitx2zh()
"~
"插件管理######################################################################################################
"use git proto insead of https,no ssl error
let g:vundle_default_git_proto = 'git'

" set the runtime path to include Vundle and initialize
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
call vundle#begin('$VIM/vimfiles/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'Yggdroot/LeaderF'
Plugin 'gtags.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'preservim/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'jszakmeister/markdown2ctags'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置Leadf插件，文件打开相关内容。By showna
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设为当前工作空间随打开文件改变
autocmd BufEnter * silent! lcd %:p:h
"autocmd BufEnter * cd %:p:h
"设置打开最近文件快捷键
nnoremap <Leader>mru :Leaderf mru<CR>
nnoremap <Leader>fl :Leaderf line<CR>
"nnoremap <Leader>ff :Leaderf file<CR>
let g:Lf_ShortcutF = '<Leader>ff'

""autocmd BufEnter * finddir('.git/..', expand('%:p:h').';')
"let g:Lf_WorkingDirectory= ["D:/python_code" , "D:/我的坚果云"]
"let g:Lf_WorkingDirectory= "D:/python_code"
"let g:Lf_CacheDirectory = "D:/python_code"
"''''''''''''''''''''''''''''  
"nerdtree setting
"auto open
"autocmd vimenter * NERDTree
map <leader>nt :NERDTree<CR>
"q 退出
map <leader>ntt :NERDTreeToggle<CR>
"ctags seeting
"生成ctags文件
map <Leader>ct :!ctags -R * <CR>
"自动切换目录并指定tag文件
set tags=tags;
"set autochdir

map <Leader>tbo :TagbarOpen<CR>
map <Leader>tbt :TagbarToggle<CR>
map <Leader>tt :TagbarOpen -j<CR>
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '$VIM/vimfiles/bundle/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim7.1在windows下的编码设置。By Huadong.Liu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
        "set fileencoding=chinese,utf-8
else
        set fileencoding=utf-8
endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8
"######################################################################################################
"win10 配 置
let $mymddir="D:/我的坚果云/md文件"
map <leader>nmy :NERDTree $mymddir<CR>
"修改后，在typora同步载入文件
function TyporaLaunch()
    " Launch Typora
    exec !"D:/Program Files/Typora/bin/typora.exe" "%:p"
    "call system("D:/Program Files/Typora/bin/typora.exe" . expand("%") . "\"")
    "setlocal autoread
endfunction
autocmd BufWritePost *.md :call TyporaLaunch()
