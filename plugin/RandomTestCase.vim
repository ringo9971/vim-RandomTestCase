scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

if exists('g:loaded_vim_RandomTestCase')
  finish
endif
let g:loaded_vim_RandomTestCase = 1

command! -nargs=+ RandomTestCase call RandomTestCase#RandomTestCase(<f-args>)


let &cpo = s:save_cpo
unlet s:save_cpo
