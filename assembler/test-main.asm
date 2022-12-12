@main

array *test

push 8
push 7
push 6

storem *test
storem *test
storem *test

loadm *test

push 0
elemr *test

push 1
elemr *test

push 2
elemr *test

push 3
elemr *test


push 4
elemr *test


ret


halt