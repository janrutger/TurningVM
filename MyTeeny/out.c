@main
call @stackssys
push 'a'
set $MEM
push 'b'
set $MEM
push 1
push 'a'
storei
push 2
push 'b'
storei
:_0_condition_start
push 'a'
loadi
push 'b'
loadi
push '!='
calli
loada
testz
jumpf :_0_repeat_end
push 'a'
loadi
prt
push 'a'
loadi
push 'a'
loadi
push '+'
calli
push 'a'
storei
jumpf :_0_condition_start
:_0_repeat_end
clra
ret
