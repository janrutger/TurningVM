@main


push 'index'
set $MEM

push 5
push 'index'
storei


push 'index'
loadi 

prt

push 'lifo'
set %LIFO

push 6
push 'lifo'
storei

push 'lifo'
loadi

prt

push 'iobuff'
set %IObuff

push 15
push 'iobuff'
storei

push 'iobuff'
loadi

prt


push 'array'
set *ARRAY

push 7
push 8

push 'array'
storei
push 'array'
storei

push 0
push 'array'
readelmi

prt

push 2
push 'array'
readelmi

prt

push 5
push 'array'
readelmi


ret