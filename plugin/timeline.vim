let g:timeline_base_dir = get(g:, 'timeline_base_dir', expand($HOME . '/timeline'))

function! s:confirm(msg)
    return input(a:msg) =~? '^y\%[es]$'
endfunction

let s:a_day = 24 * 60 * 60

function! s:open_task_sched_achv_windows(time, force)
    let year  = strftime("%Y", a:time)
    let month = strftime("%m", a:time)
    let day   = strftime("%d", a:time)

    let dir = g:timeline_base_dir . printf("/%d/%02d/%02d", year, month, day)
    if !isdirectory(dir) && (a:force || s:confirm(printf('"%s" does not exist. Create? [y/N]', dir)))
        call mkdir(dir, "p")
    endif

    execute "botright split "    . dir . "/TASK"
    execute "belowright vsplit " . dir . "/SCHEDULE"
    execute "belowright vsplit " . dir . "/ACHIEVEMENT"
endfunction

command! -nargs=0 Today call s:open_task_sched_achv_windows(localtime(), 0)
command! -nargs=0 Yesterday call s:open_task_sched_achv_windows(localtime() - s:a_day, 0)
command! -nargs=0 Tomorrow call s:open_task_sched_achv_windows(localtime() + s:a_day, 0)
