scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! RandomTestCase#RandomTestCase(...) abort
  if a:0 != 3
    echo '引数が3つで無いです'
    return
  endif

  let s:a = system('g++ -std=gnu++17 -O2 ' . a:1 . '.cpp -o random')
  let s:b = system('g++ -std=gnu++17 -O2 ' . a:2 . '.cpp -o b')
  let s:c = system('g++ -std=gnu++17 -O2 ' . a:3 . '.cpp -o c')

  let s:num = 1
  if !isdirectory('test')
    call mkdir('test', 'p')
  endif
  while exists('test/in' . s:num)
    let s:num += 1
  endwhile


  for i in range(1, 500)
    let s:in = system('./random')
    let s:out1 = system('echo ' . substitute(s:in, '\n', ' ', 'g') . ' | ./b')
    let s:out2 = system('echo ' . substitute(s:in, '\n', ' ', 'g') . ' | ./c')

    if s:out1 !=# s:out2
      call writefile([s:in],   'test/in'     . s:num)
      call writefile([s:out1], 'test/AC_out' . s:num)
      call writefile([s:out2], 'test/WA_out' . s:num)
      echo s:in[:-1] . s:out1 . s:out2
      let s:num += 1
    endif

    if i%100 == 0
      echo i-100 . ' - ' . i . 'end'
    endif
  endfor

  echo 'end'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
