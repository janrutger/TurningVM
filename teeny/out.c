@main
call @basicsys
push 'nums'
set $MEM
push 'a'
set $MEM
push 'c'
set $MEM
push 'nums'
call @input
call @swap
storei
push 'a'
push 1
call @swap
storei
:_while_start_0
call :_while_comp_0
loada
testz
jumpf :_while_end_0
jump :_while_action_0
:_while_comp_0
push 'nums'
loadi
push '>'
push 0
call @swap
calli
ret
:_while_action_0
push 'c'
push 'a'
loadi
push '*'
push 'nums'
loadi
call @swap
calli
call @swap
storei
push 'a'
push 'c'
loadi
call @swap
storei
push 'nums'
push 'nums'
loadi
push '-'
push 1
call @swap
calli
call @swap
storei
push 'a'
loadi
prt
jump :_while_start_0
:_while_end_0
clra
ret
