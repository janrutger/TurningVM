@main
settimer 0
speed 0
push 1000
storem $offset
push 1
storem $x
push 'jobinput_sine'
index $x
call @~QueJobs
:_2_condition_start
pending
push 0
call @neq
loada
testz
clra
jumpf :_2_repeat_end
result
jumpf :_3_no_result
loadm $offset
loadm $y
call @plus
call @plot
:_3_no_result
jump :_2_condition_start
:_2_repeat_end
prttimer 0
ret
@~sine
push 180
loadm $x
call @minus
loadm $x
call @mul
storem $u
push 4000
loadm $u
call @mul
push 40500
loadm $u
call @minus
call @div
storem $y
done $y
@~QueJobs
:_0_condition_start
loadm $x
push 180
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $x
prt
:lus
result
jumpf :_1_no_result
loadm $offset
loadm $y
call @plus
call @plot
jump :lus
:_1_no_result
push 'jobinput_sine'
job @~sine
loadm $x
push 1
call @plus
storem $x
jump :_0_condition_start
:_0_repeat_end
ret
