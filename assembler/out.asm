@main
settimer 0
speed 0
push 1
storem $n
push 1000
storem $end
push 1
storem $n
:_0_condition_start
loadm $n
loadm $end
call @gt
loada
testz
clra
jumpf :_0_repeat_end
call @~A002024
call @dup
call @plot
loadm $n
call @plus
storem $n
jump :_0_condition_start
:_0_repeat_end
push 1
storem $n
:_1_condition_start
loadm $n
loadm $end
call @neq
loada
testz
clra
jumpf :_1_repeat_end
call @~A002024
call @plot
loadm $n
push 1
call @plus
storem $n
jump :_1_condition_start
:_1_repeat_end
prttimer 0
ret
@~A002024
loadm $n
push 8
call @mul
call @isqrt
push 1
call @plus
push 2
call @div
ret
