@main

push 7
storem $jrk

push 3
elemr $jrk
elemr $jrk

lifo %test

push 0
elemr %test
call @swap
storem %test

elemr %test


ret


halt