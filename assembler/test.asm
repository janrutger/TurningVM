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
push 1
call @swap
storei
push 'c'
push 'a'
loadi
push '+'
push 'b'
loadi
call @swap
calli
call @swap
storei
push 'c'
loadi
prt
ret