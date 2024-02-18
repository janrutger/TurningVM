@main
settimer 0
speed 0
push 1
storem $n
push 'jobinput_job1'
index $n
call @input
storem $end
:_1_condition_start
loadm $n
loadm $end
call @neq
loada
testz
clra
jumpf :_1_repeat_end
push 'jobinput_job1'
job @~job1
:lus
result
jumpf :_2_no_result
loadm $m
call @plot
jump :lus
:_2_no_result
loadm $n
push 1
call @plus
storem $n
loadm $n
prt
jump :_1_condition_start
:_1_repeat_end
:_3_condition_start
pending
push 0
call @neq
loada
testz
clra
jumpf :_3_repeat_end
result
jumpf :_4_no_result
loadm $m
call @plot
:_4_no_result
jump :_3_condition_start
:_3_repeat_end
prttimer 0
ret
@~calc
push 1
push 8
loadm $n
call @mul
call @plus
call @isqrt
push 1
call @minus
push 2
call @div
storem $m
ret
@~voorwaarde
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
ret
@~job1
call @~calc
:_0_condition_start
call @~voorwaarde
loada
testz
clra
jumpf :_0_repeat_end
loadm $m
push 1
call @plus
storem $m
jump :_0_condition_start
:_0_repeat_end
done $m
