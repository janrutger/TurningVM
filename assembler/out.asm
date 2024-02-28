@main
settimer 0
speed 0
push 'jobinput_makeTable'
job @~makeTable
push 1
call @sleep
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
loadm *table
prt
:_4_no_result
join
jump :_3_condition_start
:_3_repeat_end
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
push 18
call @neq
loada
testz
clra
jumpf :_0_repeat_end
push 'jobinput_sine'
job @~sine
jump :_0_condition_start
:_0_repeat_end
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
@__MemAllocGlobels
push 0
storem $offset
push 1000
storem $offset
push 0
storem $x
push 0
storem $x
push 0
storem $y
array *table
push 0
storem *table
push 'jobinput_sine'
index $x
push 'jobinput_makeTable'
index $x
ret
