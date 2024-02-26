@main
settimer 0
speed 0
push 1000
storem $offset
push 1
storem $x
push 'jobinput_sine'
index $x
push 0
call @plot
call @~QueJobs
call @~AddResult
push 1
storem $x
call @~QueJobs
call @~SubResult
prttimer 0
ret
@~stepX
loadm $x
push 1
call @plus
storem $x
loadm $x
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
call @~stepX
push 180
call @neq
loada
testz
clra
jumpf :_0_repeat_end
push 'jobinput_sine'
job @~sine
jump :_0_condition_start
:_0_repeat_end
ret
@~AddResult
:_1_condition_start
pending
push 0
call @neq
loada
testz
clra
jumpf :_1_repeat_end
:lus2
result
jumpf :_2_no_result
loadm $offset
loadm $y
call @plus
call @plot
jump :lus2
:_2_no_result
join
jump :_1_condition_start
:_1_repeat_end
push 0
call @plot
ret
@~SubResult
:_3_condition_start
pending
push 0
call @neq
loada
testz
clra
jumpf :_3_repeat_end
:lus1
result
jumpf :_4_no_result
loadm $offset
loadm $y
call @minus
call @plot
jump :lus1
:_4_no_result
join
jump :_3_condition_start
:_3_repeat_end
push 0
call @plot
ret
