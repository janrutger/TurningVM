@main
call @stackssys
push 'previous'
set $MEM
push 'next'
set $MEM
push 'cfactor'
set $MEM
push 1
call @dup
call @plot
call @dup
call @plot
push 'previous'
storei
push 2
push 'next'
storei
:_0_condition_start
push 'next'
loadi
push 700
push '!='
calli
loada
testz
jumpf :_0_repeat_end
push 'previous'
loadi
push 'next'
loadi
push 'GCD'
calli
push 'cfactor'
storei
push 1
push 'cfactor'
loadi
push '=='
calli
loada
testz
jumpf :_1_do_end
push 'previous'
loadi
push 'next'
loadi
push 1
push '+'
calli
push '+'
calli
jump :nextnumber
:_1_do_end
clra
push 'previous'
loadi
push 'cfactor'
loadi
push '/'
calli
:nextnumber
call @dup
call @plot
push 'previous'
storei
push 'next'
loadi
push 1
push '+'
calli
push 'next'
storei
jump :_0_condition_start
:_0_repeat_end
clra
ret
