@main
call @basicsys
push 'teller'
set $MEM
push 'som'
set $MEM
push 'getal'
set $MEM
push 'teller'
push 1
call @swap
storei
push 'som'
push 0
call @swap
storei
:lus
push 'getal'
call @input
call @swap
storei
push 'som'
push 'som'
loadi
push '+'
push 'getal'
loadi
call @swap
calli
call @swap
storei
push 'som'
loadi
push '/'
push 'teller'
loadi
call @swap
calli
prt
push 'teller'
push 'teller'
loadi
push '+'
push 1
call @swap
calli
call @swap
storei
jump :lus
ret
