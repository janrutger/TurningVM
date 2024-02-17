@main
settimer 0
speed 0
push 1
storem $n
push 'jobinput_job1'
index $n
:_0_condition_start
loadm $n
push 5
call @gt
loada
testz
clra
jumpf :_0_repeat_end
push 'jobinput_job1'
job @~job1
loadm $n
push 1
call @plus
storem $n
jump :_0_condition_start
:_0_repeat_end
loadm $n
push 50
call @eq
loada
testz
clra
jumpf :_1_do_end
push 'jobinput_job1'
job @~job1
:_1_do_end
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
loadm $m
prt
jump :lus
:_3_no_result
join
:lus
push 1
call @sleep
jump :_2_condition_start
:_2_repeat_end
call @~hello
prttimer 0
ret
@~twice
push 2
call @mul
ret
@~job1
loadm $n
call @~twice
storem $m
loadm $m
loadm $m
call @mul
storem $m
done $m
@~hello
push 'hello\_world\_'
call @char2prtbuff
call @printbuff
ret
