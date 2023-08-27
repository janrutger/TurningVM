@main
settimer 0
call @stackssys
push 4
storem $n
call @input
storem $end
:_0_condition_start
loadm $n
loadm $end
call @neq
loada
testz
clra
jumpf :_0_repeat_end
push 1
push 8
loadm $n
call @mul
call @plus
storem $s
push 2
loadm $s
call @lt
loada
testz
clra
jumpf :_1_do_end
push 1
jump :einde
:_1_do_end
loadm $s
push 2
call @div
storem $x0
loadm $s
loadm $x0
call @div
loadm $x0
call @plus
push 2
call @div
storem $x1
:_2_condition_start
loadm $x0
loadm $x1
call @lt
loada
testz
clra
jumpf :_2_repeat_end
loadm $x1
storem $x0
loadm $s
loadm $x0
call @div
loadm $x0
call @plus
push 2
call @div
storem $x1
jump :_2_condition_start
:_2_repeat_end
loadm $x0
:einde
push 1
call @minus
push 2
call @div
storem $m
:_3_condition_start
push 1
loadm $m
call @plus
loadm $m
call @mul
push 2
loadm $n
call @mul
call @mod
push 0
call @neq
loada
testz
clra
jumpf :_3_repeat_end
loadm $m
push 1
call @plus
storem $m
jump :_3_condition_start
:_3_repeat_end
loadm $m
call @plot
loadm $n
push 1
call @plus
storem $n
jump :_0_condition_start
:_0_repeat_end
prttimer 0
ret
