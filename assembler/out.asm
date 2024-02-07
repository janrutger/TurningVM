@main
settimer 0
speed 0
push 4
storem $n
:_2_condition_start
loadm $n
push 1000
call @neq
loada
testz
clra
jumpf :_2_repeat_end
settimer 16
loadm $n
call @~isqrt
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
jumpf :_3_do_end
loadm $n
call @plot
:_3_do_end
prttimer 16
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
