@main


push 5
storem $test
push 'index'
index $test

push 0
readelm 'index'

prt


array *brommer
push 'index'
index *brommer

push 8
push 7
storem *brommer
storem *brommer

push 0
readelm 'index'

prt


push 5
storem $waarde

push 'index'
index $waarde

push 'index'
loadi

prt

push 9
push 'index'

storei

loadm $waarde

prt
ret
