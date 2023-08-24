@main
settimer 0
call @stackssys
push 23
storem $time
settimer 16
gettimer 16
loadm $time
call @sleep
gettimer 16
prttimer 16
call @swap
call @minus
prt
prttimer 0
ret
