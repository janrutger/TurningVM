@main
call @basicsys
push 'a'
set $MEM
push 'b'
set $MEM
push 'a'
push 1
call @swap
storei
push 'b'
push 1
call @swap
storei
call :_if_comp_1
loada
testz
jumpf :_if_end_1
jump :_if_action_1
:_if_comp_1
push 'a'
loadi
push '!='
push 'b'
loadi
call @swap
calli
ret
:_if_action_1
push 'a'
loadi
push '+'
push 'a'
loadi
call @swap
calli
prt
:_if_end_1
clra
ret

