" General =====================================================
set nocompatible

source $VIMRUNTIME/vimrc_example.vim " Vim with all enhancements 
source $VIMRUNTIME/mswin.vim " Remap a few keys for Windows behavior 

set clipboard+=unnamed "与Windows共享剪贴板

" 文件设置 
set nobackup " 不要备份文件
set noswapfile "不生成临时文件 
set undodir=D:/temp/vim " undo 文件存放位置

"突出现实当前行列
set cursorline
set cursorcolumn

set showmatch "设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号

set shiftwidth=4 " 设置自动缩进为4个字符
set softtabstop=4 
set tabstop=4 " 设定tab宽度为4
set expandtab " 用 space 替换tab
"set noexpandtab " 不用用 space 替换tab

set number " 显示行号
set relativenumber " 显示相对行号

" 搜索
set ignorecase  " 忽略大小写
set incsearch   " 逐字高亮

" 不要折行
set nowrap
set cindent shiftwidth=4 " c语言的缩进

" 编辑vimrc之后自动加载
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

syntax on

" 主题
set background=dark 
colorscheme solarized 

if has("win32") || has ("win64")
    set guifont=Source_Code_Pro_for_Powerline:h14 "设置编程字体
    "set guifont=SauceCodePro_Nerd_Font:h14 "设置编程字体
else
    "set guifont=DejaVu\ Mono\ Oblique\ 14 "设置编程字体
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 14 "设置编程字体
endif

" 在被分割的窗口间显示空白，便于阅读 
set fillchars=vert:\ ,stl:\ ,stlnc:\ 

" 中文乱码
set enc=utf-8
" set fencs =utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set fencs =ucs-bom,utf-8,chinese,shift-jis,gb18030,gbk,gb2312,cp936,latin1
"if has("win32") || has ("win64")
    "set fenc=""
    "set fenc=chinese
"else
    "set fenc=""
    "set fenc=utf-8
"endif

" 语言设置
"set langmenu=zh_CN.UTF-8
set helplang=cn

source $VIMRUNTIME/delmenu.vim " 解决菜单乱码
source $VIMRUNTIME/menu.vim    " 解决菜单乱码
language messages  zh_CN.UTF-8 " 解决console信息乱码

" indent 打开文件对应的插件和缩进
" on 检查文件类型
filetype plugin indent on

let mapleader = "\<Space>" 

" ===== GUI =======================================================================
if has("gui_running") 
    "au GUIEnter * simalt ~x " 窗口启动时自动最大化 
    set guioptions-=m " 隐藏菜单栏 
    set guioptions-=T " 隐藏工具栏 
    "set guioptions-=L " 隐藏左侧滚动条 
    "set guioptions-=r " 隐藏右侧滚动条 
    "set guioptions-=b " 隐藏底部滚动条 
    "set showtabline=0 " 隐藏Tab栏 
    set scrolloff=10 " 滚动条
endif 

" ===== 快捷键设置================================================
" 插入模式 F9 关闭自动缩进 
set pastetoggle=<F9>

"自动补齐{ [ ( <
inoremap { {}<esc>i 
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap ' ''<esc>i
inoremap " ""<esc>i

" 映射切换buffer的键位
nnoremap <leader><Tab> :bp<CR>
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>

" 快速切换buf
nnoremap <leader>1 :b 1<CR>
nnoremap <leader>2 :b 2<CR>
nnoremap <leader>3 :b 3<CR>
nnoremap <leader>4 :b 4<CR>
nnoremap <leader>5 :b 5<CR>
nnoremap <leader>6 :b 6<CR>
nnoremap <leader>7 :b 7<CR>
nnoremap <leader>8 :b 8<CR>
nnoremap <leader>9 :b 9<CR>

nnoremap <leader>e :e 
nnoremap <leader>bd :bd<CR> 

" 接触冲突
nnoremap <leader>w <C-w>w<CR>      " 切换窗口
nnoremap <leader>wk <C-w>k<CR>      " 
nnoremap <leader>wj <C-w>j<CR>
nnoremap <leader>wh <C-w>h<CR>
nnoremap <leader>wl <C-w>l<CR>

nnoremap  <leader>m :only<CR> " 当前窗口最大化

map <F2> @a " 自己定义的键盘映射按下F5建执行录制好的名字为a的宏

" ======== 各种插件配置,包含插件相应的快捷键 ==================
" vimwiki
source ~/.vim/vimwiki.conf 
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
let g:vim_markdown_folding_disabled=1 
let g:vim_markdown_frontmatter=1 
let g:indent_guides_start_level = 2  
let indent_guides_guide_size = 1
let g:indent_guides_space_guides = 1
let g:indent_guides_enable_on_vim_startup = 1 

" ale
let g:ale_fix_on_save = 1                   " Set this variable to 1 to fix files when you save them.
let g:airline#extensions#ale#enabled = 1    " Set this. Airline will handle the rest.
let g:ale_sign_column_always = 1            " 保持侧边栏可见
" 改变警告和错误标识
let g:ale_sign_error = '>>'                 
let g:ale_sign_warning = '--'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']   " 改变状态栏信息格式
" 改变命令行消息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" taglist 
map <leader>t :Tlist<cr> 
autocmd GUIEnter * simalt ~x
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"tag 配置 "set tags=tags;/ 
set tags=tags;/  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。
set autochdir " 文件的目录为当前目录
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 

" nerdtree 配置
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

" airline
set laststatus=2 
let g:airline_powerline_fonts = 1                       " 使用powerline打过补丁的字体
let g:airline#extensions#tabline#enabled = 1            " 开启tabline
let g:airline#extensions#tabline#left_sep = '*'         " tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'     " tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#buffer_nr_show = 1     " tabline中buffer显示编号

"ycm 配置
set pumheight=10 "弹出菜单的高度，自己定义"
"let g:ycm_server_python_interpreter='python' "使用python3
"let g:ycm_python_binary_path = 'C:\OSGeo4W64\apps\Python37'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py' " 当前目录没有 .ycm_extra_conf.py 时使用这个配置文件
let g:ycm_confirm_extra_conf = 0 " 停止提示是否载入本地ycm_extra_conf文件 
" 0 - 不记录上次的补全方式
" 1 - 记住上次的补全方式,直到用其他的补全命令改变它
" 2 - 记住上次的补全方式,直到按ESC退出插入模式为止
let g:SuperTabRetainCompletionType=2 
" 跳转快捷键
nnoremap <leader>k :YcmCompleter GoToDeclaration<CR>|
nnoremap <leader>d :YcmCompleter GoToDefinition<CR>| 
nnoremap <leader>h :YcmCompleter GoToDefinitionElseDeclaration<CR>|
"nnoremap <c-h> :YcmCompleter GoTo<CR>|
let g:ycm_seed_identifiers_with_syntax = 1 " 语法关键字补全
let g:ycm_collect_identifiers_from_tags_files = 1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=1 " 从第1个键入字符就开始罗列匹配项
let g:ycm_complete_in_comments = 1 " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1 " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
let g:ycm_key_list_select_completion = ['=', '<Down>'] " 弹出列表时选择第1项的快捷键(默认为<TAB>和<Down>)
let g:ycm_key_list_previous_completion = ['-', '<Up>'] " 弹出列表时选择前1项的快捷键(默认为<S-TAB>和<UP>)
" 主动补全, 默认为<C-Space>
"let g:ycm_key_invoke_completion = '<C-Space>'
" 停止显示补全列表(防止列表影响视野), 可以按<C-Space>重新弹出
"let g:ycm_key_list_stop_completion = ['<C-y>']

" 设置按下<Tab>后默认的补全方式, 默认是<C-P>, 
" 现在改为<C-X><C-O>. 关于<C-P>的补全方式, 
" 还有其他的补全方式, 你可以看看下面的一些帮助:
" :help ins-completion
" :help compl-omni
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"全局引用命名空间也可以提示
let g:ycm_semantic_triggers =  {
            \   'c' : ['->', '.','re![_a-zA-z0-9]'],
            \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
            \             're!\[.*\]\s'],
            \   'ocaml' : ['.', '#'],
            \   'cpp,objcpp' : ['->', '.', '::','re![_a-zA-Z0-9]'],
            \   'perl' : ['->'],
            \   'php' : ['->', '::'],
            \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
            \   'ruby' : ['.', '::'],
            \   'lua' : ['.', ':'],
            \   'erlang' : [':'],
            \ } 

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Vim-easy-Align 快速对齐插件
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" indentline 
nnoremap <leader>il :IndentLinesToggle<CR> " 开关匹配线
" let g:indentLine_char = '¦'
"let g:indentLine_char = '┆'

" 彩虹括号
let g:rainbow_active = 1 

" unite
map <leader>u :Unite buffer file_rec -input=

" ===== vim-plug 插件管理 ============================
let $PLUG_DIR = expand("~/.vim/autoload") 
if has("win32") || has ("win64")
    let $PLUG_DIR = expand("~/vimfiles/autoload") 
endif

let $PLUGINS_DIR = expand("~/.vim/plugged")   " 插件安装目录

"安装命令:PlugInstall
silent! call plug#begin(expand('$PLUGINS_DIR'))
Plug 'vimwiki/vimwiki'
"Plug 'itchyny/calendar.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'Valloric/YouCompleteMe' 
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'vim-scripts/NSIS-syntax-highlighting'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
call plug#end()
