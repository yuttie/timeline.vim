let g:timeline_base_dir = get(g:, 'timeline_base_dir', expand($HOME . '/timeline'))

function! s:confirm(msg)
    return input(a:msg) =~? '^y\%[es]$'
endfunction

function! s:today(force)
    let year  = strftime("%Y")
    let month = strftime("%m")
    let day   = strftime("%d")

    let dir = g:timeline_base_dir . printf("/%d/%02d/%02d", year, month, day)
    if !isdirectory(dir) && (a:force || s:confirm(printf('"%s" does not exist. Create? [y/N]', dir)))
        call mkdir(dir, "p")
    endif

    execute "botright split "    . dir . "/TASK"
    execute "belowright vsplit " . dir . "/SCHEDULE"
    execute "belowright vsplit " . dir . "/ACHIEVEMENT"
endfunction

command! -nargs=0 Today call s:today(0)
