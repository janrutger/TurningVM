@main
settimer 0
speed 0
push 4
storem $n
call @input
storem $end
:_2_condition_start
loadm $n
loadm $end
call @neq
loada
testz
clra
jumpf :_2_repeat_end
push 1
push 8
loadm $n
call @mul
call @plus
call @~isqrt
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
jump :_2_condition_start
:_2_repeat_end
prttimer 0
ret
@~isqrt
storem $y
push 0
storem $L
loadm $y
push 1
call @plus
storem $R
:_0_condition_start
loadm $L
loadm $R
push 1
call @minus
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $L
loadm $R
call @plus
push 2
call @div
storem $M
loadm $M
loadm $M
call @mul
loadm $y
call @lt
loada
testz
clra
jumpf :_1_do_end
loadm $M
storem $R
jump :done
:_1_do_end
loadm $M
storem $L
:done
jump :_0_condition_start
:_0_repeat_end
loadm $L
ret
