@main

iobuff %test

push 'xyz'
index %test

push 2
push 40

storem %test
storem 'xyz'

loadm %test
loadm 'xyz'



push '+'
index @plus

push '+'
calli

prt

ret


halt