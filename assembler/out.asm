@main
settimer 0
speed 0
push 0
storem $offset
push 1000
storem $offset
push 0
storem $x
push 1
storem $x
push 0
storem $y
push 'jobinput_sine'
index $x
push 'jobinput_makeTable'
index $x

push 'jobinput_makeTable'
job @~makeTable

:_3_condition_start
pending
push 1
call @eq
loada
testz
clra
jumpf :_3_repeat_end
result
jumpf :_4_no_result
loadm *table
prt
:_4_no_result
jump :_3_condition_start
:_3_repeat_end
loadm *table
prt
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

@~makeTable
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
array *table
push 0
storem *table
:_1_condition_start
pending
push 0
call @neq
loada
testz
clra
jumpf :_1_repeat_end
result
jumpf :_2_no_result
loadm $y
storem *table
:_2_no_result
jump :_1_condition_start
:_1_repeat_end
done *table
