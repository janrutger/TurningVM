@main
array *test


push 3
push 8
push 5
storem *test
storem *test
storem *test

push '_input_plotarray'
index *test

call @plotnew
call @plotarray

ret