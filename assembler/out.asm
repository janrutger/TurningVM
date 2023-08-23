@main
settimer 0
call @stackssys
push 6
call @sleep
push 5
push 5
call @plus
prt
prttimer 0
ret
