@main

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
