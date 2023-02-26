@main
call @basicio
push 'a'
set $MEM
push 'b'
set $MEM
push 'c'
set $MEM
push 10
prt
push 'a'
push 5
call @swap
storei
push 'b'
push 4
call @swap
storei
push 'c'
push 'a'
loadi
push '+'
push 'b'
loadi
push '/'
push 2
call @swap
calli
call @swap
calli
call @swap
storei
push 'c'
loadi
prt
push 'c'
loadi
push '*'
push 3
call @swap
calli
prt
ret
