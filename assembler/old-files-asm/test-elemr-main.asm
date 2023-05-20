@main



push 8
push 7
push 6



array *brommer

storem *brommer
storem *brommer
storem *brommer


push 0
readelm *brommer

push 1
readelm *brommer

push 2
readelm *brommer

push 3
readelm *brommer

push 4
readelm *brommer

prt
prt
prt
prt

push '+'
index @plus

push 0
readelm '+'

ret


halt