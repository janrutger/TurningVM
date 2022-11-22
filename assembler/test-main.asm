@main
speed 6

push 5
push 3

push '+'
index @plus

push '+'
calli

input

loadm %_kbd
loadm %_kbd


ret


halt