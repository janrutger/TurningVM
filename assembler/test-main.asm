@main
 
push 2
storem $test

push 'xyz'
index $test
loadm 'xyz'

push 4
storem 'xyz'
loadm $test

push '+'
index @plus

push '+'
calli

prt

ret


halt