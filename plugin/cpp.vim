command! Mkfun lua require("funcs").mkfun()
command! -nargs=1 -range Com :call luaeval("require('funcs').com(_A[4])", [<line1>,<line2>, <count>, <f-args>])
command! -nargs=1 -range Unc :call luaeval("require('funcs').unc(_A[4])", [<line1>,<line2>, <count>, <f-args>])

