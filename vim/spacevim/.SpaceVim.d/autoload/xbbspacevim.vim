function! xbbspacevim#before() abort
    let g:spacevim_default_indent = 4

    let g:neomake_m1_maker = {
                \ 'exe': 'make',
                \ 'args': ['--build'],
                \ 'errorformat': '%f:%l:%c: %m',
                \ }➭ 

    let g:neomake_cpp_m1_maker = {
                \ 'exe': 'make',
                \ 'args': ['--build'],
                \ 'errorformat': '%f:%l:%c: %m',
                \ }➭ 
endfunction

function! xbbspacevim#after() abort
endfunction
