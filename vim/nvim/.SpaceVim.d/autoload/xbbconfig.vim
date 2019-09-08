" vimwiki配置
function! xbbconfig#before() abort
  " python 虚拟环境
  "let g:python_host_prog = '/full/path/to/neovim2/bin/python'
  let g:python3_host_prog = 'D:/tools/venv/Scripts/python.exe'

  " =========vimwiki====================
  let wiki_1={}
  let wiki_1.index='work'
  let wiki_1.path = 'D:/workspace/study/wiki_work'
  let wiki_1.syntax='markdown'
  let wiki_1.ext='.md'

  let wiki_2={}
  let wiki_2.index = 'personal'
  let wiki_2.path = 'D:/workspace/study/wiki/'
  let wiki_2.ext='.md'
  let wiki_2.nested_syntaxes={'python': 'python','c++': 'cpp','winbatch': 'winbatch'}

  let g:vimwiki_use_mouse = 1
  let g:vimwiki_list = [wiki_1,wiki_2]
  let g:vimwiki_ext2syntax={'.md':'markdown','.markdown':'markdown','.mdown':'markdown'}

  " 标记为完成的 checklist 项目会有特别的颜色
  let g:vimwiki_hl_cb_checked = 1
  au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
  let g:vim_markdown_folding_disabled=1 
  let g:vim_markdown_frontmatter=1 
  let g:indent_guides_start_level = 2  
  let indent_guides_guide_size = 1
  let g:indent_guides_space_guides = 1
  let g:indent_guides_enable_on_vim_startup = 1 

  nnoremap <leader>kd :VimwikiMakeDiaryNote<cr> 

  "==============calendar 配置
  " 打开日历控
  nnoremap <leader>dl :Calendar<cr> 

  "==============easy-aligin 代码对其插件配置
  xmap     <leader>a <Plug>(EasyAlign)
  nmap     <leader>a <Plug>(EasyAlign)


  "set nobackup " 不要备份文件
  set noswapfile "不生成临时文件 
  "set undodir=D:/temp/vim " undo 文件存放位置

  "=======deoplete-jedi config
  let g:deoplete#sources#jedi#statement_length=20   " 提示长度
  let g:deoplete#sources#jedi#enable_typeinfo=1     " 参数类型信息
  let g:deoplete#sources#jedi#show_docstring=0
  "let g:deoplete#sources#jedi#extra_path=["",""]   " 添加到sys.path\
  "的其他目录

  "autocmd FileType cpp let g:spacevim_enable_ycm=1


endfunction

function! xbbconfig#after() abort
    iunmap jk
endfunction
