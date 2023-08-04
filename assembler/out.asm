@main
call @stackssys
push 4
storem $n
:_0_condition_start
loadm $n
push 1000
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $n
prt
loadm $n
push 2
call @div
:_1_condition_start
call @dup
call @dup
call @mul
loadm $n
call @lt
loada
testz
clra
jumpf :_1_repeat_end
push 1
call @minus
jump :_1_condition_start
:_1_repeat_end
storem $i
loadm $i
push 1
call @minus
call @factorial
loadm $i
call @mod
loadm $i
push 1
call @minus
call @eq
loada
testz
clra
jumpf :_2_do_end
loadm $n
call @plot
:_2_do_end
loadm $n
push 1
call @plus
storem $n
jump :_0_condition_start
:_0_repeat_end
ret
