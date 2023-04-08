vim.api.create_user_command('Files', 'call fzf#vim#files(<q-args>, {"source": "ag --hidden --ignore .git"})', {})
-- command! -bang -nargs=? -complete=dir Files
--    call fzf#vim#files(<q-args>, {'source': 'ag --hidden --ignore .git -g ""'}, <bang>0)
-- command! -bang -nargs=* Buffers
--        call fzf#vim#buffers({'source': map(fzf#vim#_buflisted_sorted(), 'fzf#vim#_format_buffer(v:val)')}, <bang>0)
-- command! -bang -nargs=* Rg
--    call fzf#vim#grep(
--      'rg --column --line-number --no-heading --color=always --smart-case --hidden -- '.shellescape(<q-args>), 1,
--      fzf#vim#with_preview(), <bang>0)

-- vim. g.fzf_action = {
--    'ctrl-y'= 'edit',
--    'ctrl-x'= 'split',
--    'ctrl-v'= 'vsplit',
--    }
