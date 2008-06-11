if exists("loaded_hobo") || &cp 
  finish 
endif

function! s:Instantiate()
  call inputsave()
  let $HOBO_TAG_NAME = input("Tagname: ")
  let $HOBO_ROOT = b:rails_root
  call inputrestore()
  return system("ruby $HOME/bin/instantiate_tag.rb")
endfunction

function! s:Complete(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '[-a-z]'
      let start -= 1
    endwhile
    return start
  else
    let $HOBO_TAG_NAME=a:base
    let $HOBO_ROOT = b:rails_root
    let output = system("ruby $HOME/bin/autocomplete_tag.rb")
    return split(output)
  end
end
endfunction


" --- key mappings --- "

if !hasmapto('<Plug>HoboInstantiate', 'i')
  imap <F5> <Plug>HoboInstantiate
endif
inoremap <unique> <script> <Plug>HoboInstantiate <SID>Instantiate
inoremap <silent> <SID>Instantiate <c-o>:mark h<CR><c-r>=<SID>Instantiate()<CR><c-o>'h<esc>

map <SID>xx <SID>xx
let s:sid = maparg("<SID>xx")
unmap <SID>xx
let s:sid = substitute(s:sid, 'xx', '', '')

" eruby highlighting:
"autocmd BufNewFile,BufRead *.dryml setlocal filetype=eruby
"autocmd BufNewFile,BufRead *.dryml syn match htmlTagName contained "\<\([a-zA-Z0-9-]\+\)\>"

" OR xml highlighting (+ indentation)
autocmd BufNewFile,BufRead *.dryml setlocal filetype=xml

exec "autocmd BufNewFile,BufRead *.dryml set omnifunc=" . s:sid . "Complete"
