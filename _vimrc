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
"�ٿ�����
"######################################################################################################
"self map setting
let mapleader = " "
inoremap jj <Esc>
vmap <leader><leader>y "+y
map <leader><leader>p "+gP
"��<c-r>���ϼĴ���������������������Ĵ�������
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
"ʹ��>><<���Լ�=���Զ�����ʱ�������ո�
set shiftwidth=4
set expandtab
set nu
"hightlight search result
set hlsearch
"ignore case in search
set ic
"�������ʱ���ִ�д���Ͳ����Դ�Сд
set smartcase

syntax enable
set background=light
colorscheme solarized
"######################################################################################################
"�޸ĺ��Զ�����vimrc
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
"�������######################################################################################################

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
"����Leadf������ļ���������ݡ�By showna
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"��Ϊ��ǰ�����ռ�����ļ��ı�
autocmd BufEnter * silent! lcd %:p:h
"autocmd BufEnter * cd %:p:h
"���ô�����ļ���ݼ�
nnoremap <Leader>mru :Leaderf mru<CR>
nnoremap <Leader>fl :Leaderf line<CR>
"nnoremap <Leader>ff :Leaderf file<CR>
let g:Lf_ShortcutF = '<Leader>ff'

""autocmd BufEnter * finddir('.git/..', expand('%:p:h').';')
"let g:Lf_WorkingDirectory= ["D:/python_code" , "D:/�ҵļ����"]
"let g:Lf_WorkingDirectory= "D:/python_code"
"let g:Lf_CacheDirectory = "D:/python_code"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim7.1��windows�µı������á�By Huadong.Liu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
        set fileencoding=chinese
else
        set fileencoding=utf-8
endif
"����˵�����
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"���consle�������
language messages zh_CN.utf-8

