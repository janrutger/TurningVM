@main
 
push 2
storem $test

push 'xyz'
index $test

loadm 'xyz'

prt

push 4
storem 'xyz'
loadm $test
prt

ret


halt